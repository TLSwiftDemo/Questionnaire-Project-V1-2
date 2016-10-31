//
//  DataViewController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class DataViewController: UIViewController {
    
    var dataObject:String = ""
    
    var toolBar:UIToolbar!
    var previousBtn:UIBarButtonItem!
    var nextBtn:UIBarButtonItem!
    
  
    //MARK: - Define some view
    var contentView: UIView!
    var titleLabel: UILabel!
    var questionLb:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        initView()
        initToolBar()
    }
    
    
    
   
    
    
    func initToolBar() -> Void {
        toolBar = UIToolbar()
        self.view.addSubview(toolBar)
        
        toolBar.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(50)
            make.right.equalTo(0)
        }
        
        // the button of previous question
        previousBtn = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(previousAction(btn:)))
        
        nextBtn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction(btn:)))
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        
        toolBar.setItems([previousBtn,spaceBtn,nextBtn], animated: true)
    }
    
    func initView() -> Void {
        
        //标题
        if titleLabel == nil{
            titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
            self.view.addSubview(titleLabel)
            
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(30)
                make.left.equalTo(0)
                make.right.equalTo(0)
            }
        }
      
        if contentView == nil{
            contentView = UIView()
            contentView.backgroundColor = UIColor.orange
            self.view.addSubview(contentView)
            
            contentView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(-50)
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
            }
        }
       
        
        
    }
    
    func previousAction(btn:UIBarButtonItem) -> Void {
        print("点击了previous")
    }
    
    func nextAction(btn:UIBarButtonItem) -> Void {
        print("点击了next")
    }

  

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

extension DataViewController{
    public func initQuestion(dict:[String:AnyObject]) -> Void{
        /*
         {
         "name": "question-1",
         "type": "single-option",
         "title": "Q 1",
         "question": "How much have you enjoyed COMP327 practicals so far?",
         "choices": [
         {
         "label": "not at all",
         "value": 1
         },
         {
         "label": "a little",
         "value": 2
         },
         {
         "label": "somewhat",
         "value": 3
         },
         {
         "label": "quite a lot",
         "value": 4
         },
         {
         "label": "Very much",
         "value": 5
         }
         ]
         }
         */
        
        initView()
        guard let name = dict["name"]  else {
            return
        }
        guard let title = dict["title"] else {
            return
        }
        guard let question = dict["question"] else {
            return
        }
        
        guard let choices = dict["choices"]  else {
            return
        }
        
        let type = dict["type"]
        
        
        
        let titleLb = UILabel()
        titleLb.numberOfLines = 0
        titleLb.lineBreakMode = .byCharWrapping
        titleLb.text = question as! String
        self.contentView.addSubview(titleLb)
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(10)
            make.right.equalTo(0)
            
        }
        
    }

}

