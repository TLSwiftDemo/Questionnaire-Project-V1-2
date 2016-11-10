//
//  Question3Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import CoreData

class Question3Controller: DataViewController {

     var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    var operationView:PlusAndMinusView!
    //问题的字典数据
    var questionDict:[String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /// 添加验证
    ///
    /// - returns: 是否通过
    override func validate() -> Bool {
        if operationView.count == 0{
            QuestionUtil.showAlert(title: "请设置数量", vc: self)
            return false
        }
        return true
    }
    override func addQuestion() {
        let q1 = Question.getQuestionById(qid: outputUUID, inManagedObjectContext: context!)
        if q1 != nil{
            self.question = q1
        }else{
            self.question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
            question.id = outputUUID
        }
        
        
        let name = questionDict["name"] as? String
        let quesitonStr = questionDict["question"] as? String
        let answerLabel = operationView.count
        
        question.answerTime = DateUtil.getCurrentTime(formatter: nil)
        
        
        question.name = name
        question.type = questionDict["type"] as? String
        question.question = quesitonStr
        question.chioceLabel = "\(answerLabel)"
        
        do {
//            try context?.save()
            
            if !appDelegate.globalQuestionsList.isContains(item: question){
                appDelegate.globalQuestionsList.append(question)
            }
            
            print("Question3Controller.globalQuestionsList.count=\(appDelegate.globalQuestionsList.count) ")
            
        }

    }


    override func buildUI(dict: [String : AnyObject]) {
        super.buildUI(dict: dict)
        
        questionDict = dict
        if outputUUID.isEmpty == false{
            return
        }
        outputUUID = QuestionUtil.randomSmallCaseString(length: 5)
        
        if let choices = dict["choices"]{
            arrayData = choices as! [[String : AnyObject]]
        }
        
        if operationView == nil{
            operationView = PlusAndMinusView()
            operationView.backgroundColor = UIColor(red:253/255, green:245/255, blue:230/255, alpha:1)

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
