//
//  DataViewController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit
import CoreData


protocol NN_DataViewControllerProtocol:NSObjectProtocol {
    /**
     上一页
     
     - parameter index: 索引
     
     - returns:
     */
    func prevAction(dataViewController:DataViewController?) -> Void;
    /**
     下一页
     
     - parameter index: 索引
     
     - returns:
     */
    func nextAction(dataViewController:DataViewController?) -> Void;
    

    
}

class DataViewController: UIViewController {
    
    var dataObject:String = ""
    
    var toolBar:UIToolbar!
    var previousBtn:UIBarButtonItem!
    var nextBtn:UIBarButtonItem!
    
    var delegate:NN_DataViewControllerProtocol?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext?
    //作为全局的uuid字符串
    var outputUUID:String = ""
    
  
    //MARK: - Define some view
    var contentView: UIView!
    var titleLabel: UILabel!
    var questionLb:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initToolBar()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        context = appDelegate.persistentContainer.viewContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func buildUI(dict:[String:AnyObject]) -> Void {
        
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
            contentView.backgroundColor = UIColor.clear
            self.view.addSubview(contentView)
            
            contentView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(-55)
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
            }
        }
        
        if questionLb == nil{
            questionLb = UILabel()
            questionLb.lineBreakMode = .byCharWrapping
            questionLb.numberOfLines = 0
            self.contentView.addSubview(questionLb)
            
            questionLb.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(30)
                make.left.equalTo(0)
                make.right.equalTo(0)
            }
        }
       
        
        
        
    }
    
    func previousAction(btn:UIBarButtonItem) -> Void {
        print("点击了previous")
        self.delegate?.prevAction(dataViewController: self)
        
        addQuestion()
    }
    
    func nextAction(btn:UIBarButtonItem) -> Void {
        print("点击了next")
        
        self.delegate?.nextAction(dataViewController: self)
        
       addQuestion()
    }

    func addQuestion() -> Void {
        
    }
  

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

extension DataViewController{
    public func initQuestion(dict:[String:AnyObject]) -> Void{
      
        
        initView()
        buildUI(dict: dict)
        
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
        
        
        self.titleLabel.text = name as? String
        self.questionLb.text = question as? String
        
        
    }
    
   

}

