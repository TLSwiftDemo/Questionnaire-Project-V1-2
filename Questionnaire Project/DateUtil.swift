//
//  DateUtil.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class DateUtil: NSObject {

  static func getCurrentTime(formatter:String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        print(Date())
    
        let temp = "yyyy-MM-dd HH:mm:ss"
        if formatter == nil{
            dateFormatter.dateFormat = temp
        }
//        dateFormatter.dateFormat = formatter

        let dateStr = dateFormatter.string(from: Date())
        
        return dateStr
    }
}
