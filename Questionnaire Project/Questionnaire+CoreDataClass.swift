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

    
  }
