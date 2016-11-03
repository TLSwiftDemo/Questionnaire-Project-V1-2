//
//  QuestionModel.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

/// 文件缓存存放的路径
let QuestionnairePath:String = "/Questionnaire"

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
    

    /// get data from server
    ///
    /// - returns: json data
    static func getJsonDataFromServer(completionHandler:((_ dict:[String:AnyObject])->())?,errorHandler:((Error)->())?)->Void{
    
        let defaultConfiguration = URLSessionConfiguration.default
        //        let operationQueue = OperationQueue.main
        let session = URLSession(configuration: defaultConfiguration)
        
        let url = URL(string: "https://cgi.csc.liv.ac.uk/~phil/COMP327/questionnaire.json")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            print("Got response :\(response) with error \(error)\n");
            if let data = data {
                
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("data:\(str)")
                
                let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(dict)
                
                if let handler = completionHandler {
                    handler(dict as! [String : AnyObject])
                }
                
                
                //保存到硬盘
                (dict as! NSDictionary).write(toFile: getFilePath(path: QuestionnairePath), atomically: true)
   
            }
        }
        
        task.resume()
        
    }
    
    /// 从缓存中读取数据
    ///
    /// - returns:
    static  func getJsonFromCatch() -> [String:AnyObject]? {
        let fileManager = FileManager.default
        let path = QuestionModel.getFilePath(path: QuestionnairePath)
        let isExists = fileManager.fileExists(atPath: path)
        if isExists == true{
           let dict = NSDictionary(contentsOfFile: getFilePath(path: QuestionnairePath))
            return dict as! [String : AnyObject]?
        }
        
        return nil
    }
    
   static func getFilePath(path:String) -> String {
//        let homeDirectory = NSHomeDirectory()
        
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = documents[0]
        
        let resultPath = documentPath + path
        return resultPath
        
        
    }
    
}
