//
//  Question+CoreDataClass.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import CoreData


typealias resultTuple = (name:String,value:Int)

@objc
public class Question: NSManagedObject {
    
    

    class  func getQuestionById(qid questionId:String,inManagedObjectContext context:NSManagedObjectContext) -> Question? {
        let request = NSFetchRequest<Question>(entityName: "Question")
        
        request.predicate = NSPredicate(format: "id = %@", questionId)
        do{
        
            if let question = (try? context.fetch(request))?.first{
              return question
            }
        }
        
        return nil
    }
    
    class  func deleteQuestion(question:Question,context:NSManagedObjectContext) -> Void {
        do {
             context.delete(question)
             try? context.save()
         }
    }
    
    
   /// 根据问题类型查询有多少个问题
   ///
   /// - parameter type:    问题类型
   /// - parameter context: 上下文
   ///
   /// - returns:
   class func getAllByType(type:String,context:NSManagedObjectContext) -> [Question]? {
        let request = NSFetchRequest<Question>(entityName: "Question")
        let predicate = NSPredicate(format: "type = %@", type)
        request.predicate = predicate
    
        do {
            if let array = try? context.fetch(request) {
                return array
            }
        }
        
        return nil
    }
    
    
    
    /// 根据回答问题的人数切割数据
    ///
    /// - returns: 返回一个元组
    class func splitCountByAnswer(type:String,context:NSManagedObjectContext) ->[resultTuple]? {
    
        var labels = [String]()
      
        var tuplesArray = [(name:String,value:Int)]()
  
        if let array = Question.getAllByType(type:type, context: context){
            
            //第一遍循环把所有回答的问题记录下来
            for item in array {
                if labels.contains(item.chioceLabel!) == false{
                   labels.append(item.chioceLabel!)
                }
            }
            
          
        
            //第二遍循环把每个问题的回答的人数记录下来
            var tuple:resultTuple?
            
            for lb in labels {
                var count:Int = 0
                var name = ""
                for item in array {
                    if lb == item.chioceLabel{
                        count += 1
                        name = lb
                        if type == QuestionType.numeric.rawValue{
                          name = "\(name)个设备"
                        }else if(type == QuestionType.multiOption.rawValue){
                          name = item.chioceValue!
                        }
                        tuple = (name,count)
                    }
                }
                
                if tuple != nil{
                    tuplesArray.append(tuple!)
                }
            }
            
        }
        
        return tuplesArray
    
    }
    
    
    
    
   }



