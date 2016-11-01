//
//  Question4Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class Question4Controller: DataViewController,UITextViewDelegate {

    var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    var textView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func buildUI(dict: [String : AnyObject]) {
        super.buildUI(dict: dict)
        
        if let choices = dict["choices"]{
            arrayData = choices as! [[String : AnyObject]]
        }
        
        if textView == nil{
            textView = UITextView()
            textView.layer.borderColor = UIColor.red.cgColor
            textView.layer.borderWidth = 2
            textView.returnKeyType = .done
            textView.delegate = self
            self.contentView.addSubview(textView)
            
            textView.backgroundColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 17)
            
            textView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(self.questionLb.snp.bottom).offset(30)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                make.right.equalTo(0)
            }
        }
        
    }
    
    //MARK: - UITextView delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        
        return true;
    }
}
