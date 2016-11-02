//
//  Question4Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class Question4Controller: DataViewController,UITextViewDelegate {

    var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    var textView:UITextView!
    //问题的字典数据
    var questionDict:[String:AnyObject]!
    
    var question:Question!
    var output:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func initToolBar() {
        super.initToolBar()
        
        let submitBtn = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitAction))
        submitBtn.tintColor = UIColor.red
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([previousBtn,spaceBtn,submitBtn,spaceBtn,nextBtn], animated: true)

    }
    
    func submitAction()  {
        print("点击提交了")
        if question == nil{
           return
        }
        
        var questionnaire = Questionnaire.getQuestionnaireById(questionNaireid: output, context: context!)
        
        if questionnaire == nil{
           questionnaire = NSEntityDescription.insertNewObject(forEntityName: "Questionnaire", into: context!) as? Questionnaire
        }
        questionnaire?.time = DateUtil.getCurrentTime(formatter: nil)
        questionnaire?.name = output
        
        
        question.newRelationship = questionnaire
        
        do {
            try context?.save()
            print("调查问卷对象保存成功了")
            
            let resultVc = ResultController()
            self.navigationController?.pushViewController(resultVc, animated: true)
            
        } catch  {
            print(error)
        }
     
    }
    
    //MARK: - 提交答案
    override func addQuestion() {
      
        
        
        let q1 = Question.getQuestionById(qid: output, inManagedObjectContext: context!)
        if q1 != nil{
          question = q1
        }else{
           question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
        }
     
        
        
        let name = questionDict["name"] as? String
        let quesitonStr = questionDict["question"] as? String
        let answer = textView.text
        
    
        let quesitonnaire = Questionnaire(context: context!)
        quesitonnaire.time = DateUtil.getCurrentTime(formatter: nil)
        quesitonnaire.name = DateUtil.getCurrentTime(formatter: nil)
     
        question.id = output
        question.answerTime = DateUtil.getCurrentTime(formatter: nil)
        
        question.name = name
        question.type = questionDict["type"] as? String
        question.question = quesitonStr
        question.chioceLabel = answer
        
        
        
        
        do {
            try context?.save()
            print("saved data ")
            
        } catch {
            print("error:\(error)")
        }
    

    }

    override func buildUI(dict: [String : AnyObject]) {
        super.buildUI(dict: dict)
        
        questionDict = dict
        output = randomSmallCaseString(length: 10)
        
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

extension Question4Controller{
   
    func randomSmallCaseString(length: Int) -> String {
        
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
}
