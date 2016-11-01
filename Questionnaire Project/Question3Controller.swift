//
//  Question3Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class Question3Controller: DataViewController {

     var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    var operationView:PlusAndMinusView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func buildUI(dict: [String : AnyObject]) {
        super.buildUI(dict: dict)
        
        if let choices = dict["choices"]{
            arrayData = choices as! [[String : AnyObject]]
        }
        
        if operationView == nil{
            operationView = PlusAndMinusView()
            operationView.backgroundColor = UIColor.gray
            self.contentView.addSubview(operationView)
            
            operationView.snp.makeConstraints { (make) in
                make.left.equalTo(30)
                make.right.equalTo(-30)
                make.top.equalTo(self.questionLb.snp.bottom).offset(30)
                make.height.equalTo(60)
            }
        }
        
        
        
        
        
        
    }
}
