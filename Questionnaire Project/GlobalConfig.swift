//
//  GlobalConfig.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/9.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import UIKit

/// 问题类型
///
/// - singleOption: singleOption
/// - multiOption:  multiOption
/// - numeric:      numeric
/// - text:         text
enum QuestionType:String {
    case singleOption = "single-option"
    case multiOption = "multi-option"
    case numeric = "numeric"
    case text = "text"
}

/// 页面的背景颜色
let COLOR_BG:UIColor =  UIColor(red:144/255, green:238/255, blue:144/255, alpha:1)




