//
//  Question+CoreDataClass.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import CoreData

@objc
public class Question: NSManagedObject {
    
    

    class  func getQuestionById(qid questionId:String,inManagedObjectContext context:NSManagedObjectContext) -> Question? {
        let request = NSFetchRequest<Question>(entityName: "Question")
        
        request.predicate = NSPredicate(format: "id = %@", questionId)
        do{
        
            if let question = (try? context.fetch(request))?.first{
              return question
            }
        }catch {
          print(error)
        }
        
        return nil
    }
    
   }
