//
//  QuestionModel.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class QuestionModel: NSObject {

    static func getJsonData()->[String:AnyObject]?{
        let filePath = Bundle.main.path(forResource: "questionaire", ofType: "json")
        
        if let filePath = filePath {
            let url = URL(fileURLWithPath: filePath)
            
            let data = try? Data(contentsOf: url)
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
            
            let jsonDict = jsonData as! [String:AnyObject]
            
            print("jsonDict:\(jsonDict)")
            
            return jsonDict
            
        }
        
        return nil
    }
}
