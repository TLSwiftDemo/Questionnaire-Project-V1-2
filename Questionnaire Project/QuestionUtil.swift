//
//  QuestionUtil.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

var questionnaireUUIDString = ""

class QuestionUtil: NSObject {
    
  static func randomSmallCaseString(length: Int) -> String {
    
        var output = ""
        if output.isEmpty == false{
            return output
        }
        
        for _ in 0..<length {
            let randomNumber = arc4random() % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        
        return output
    }
    
    
    static func generateUUID() -> String{
        if questionnaireUUIDString.isEmpty{
            questionnaireUUIDString = QuestionUtil.randomSmallCaseString(length: 12)
        }
        
        return questionnaireUUIDString
    }
    
    
    static func clearUUID() -> Void{
       questionnaireUUIDString = ""
    }
    
    
}

extension Array{
    mutating func removeObj(item:AnyObject) -> Void {
        
        var index = 0
        for obj in self {
            if obj as AnyObject === item{
                self.remove(at: index)
                break
            }
            index = index + 1
        }
        
        
    }
    
   mutating func isContains(item:Question) -> Bool {
        
        for obj in self {
            if (obj as! Question).id == item.id{
              return true
            }
        }
        return false
    }
}
