//
//  Questionnaire+CoreDataClass.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import CoreData

@objc
public class Questionnaire: NSManagedObject {
    
    
    /// 根据问卷的Id获取问卷对象
    ///
    /// - parameter questionNaireid: 问卷对象的Id
    /// - parameter context:         coreData的上下文
    ///
    /// - returns: 调查问卷
    class func getQuestionnaireById(questionNaireid:String,context:NSManagedObjectContext) -> Questionnaire? {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
        request.predicate = NSPredicate(format: "name = %@", questionNaireid)
        do {
            if let questionnaireEntity = try? context.fetch(request).first {
                //if found in database,return it directly
                return questionnaireEntity
            }
        } catch  {
            print(error)
        }
        
        return nil
    }
    
    
    /// 删除调查问卷
    ///
    /// - parameter questionnaire: 调查问卷的实体
    /// - parameter context:       coreData的上下文
    class func deleteQuestionnaire(questionnaire:Questionnaire,inContextObjectContext context:NSManagedObjectContext) -> Void {
        
        do {
            
         //删除对应的问题
            for item in questionnaire.questionList! {
               let question = (item as! Question)
               Question.deleteQuestion(question: question, context: context)
            }
            
             context.delete(questionnaire)
            
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    
    /// 获取调查问卷中对应的问题 传0就是第一个问题，传1就是第二个问题，一次类推
    ///
    /// - parameter qustionIndex: 问卷中问题的索引
    ///
    /// - returns: 要查询的所有回答过的问题
    class func getAllByQuestionType(type:QuestionType,context:NSManagedObjectContext) -> [Question]? {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
//        let predicate = NSPredicate(format: "questionList", <#T##args: CVarArg...##CVarArg#>)
        
        
        var result:[Question] = [Question]()
        do {
            if let array = try? context.fetch(request) {
                
                for item in array {
                    if let questionArray  = item.questionList{
                        for question in questionArray {
                            let que = question as! Question
                            if QuestionType(rawValue: que.type!) == type{
                                result.append(que)
                            }
                        }
                    }
                }
                
                return result
            }
        } catch  {
            print(error)
        }
        
        
        return nil
    }
    
    

    
  }
