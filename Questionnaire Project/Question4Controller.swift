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

class Question4Controller: DataViewController,UITextViewDelegate,UINavigationControllerDelegate {

    var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
     var tipAlert:UIAlertController!
    var textView:UITextView!
    //问题的字典数据
    var questionDict:[String:AnyObject]!
    
    
    var questionNaireUUID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
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
        
        if validate() == false{
          return
        }
        if question == nil{
            addQuestion()
        }
        
        if questionNaireUUID.isEmpty == true{
            questionNaireUUID = QuestionUtil.generateUUID()
        }
        
        var questionnaire = Questionnaire.getQuestionnaireById(questionNaireid: questionNaireUUID, context: context!)
        
        if questionnaire == nil{
           questionnaire = NSEntityDescription.insertNewObject(forEntityName: "Questionnaire", into: context!) as? Questionnaire
        }
        questionnaire?.time = DateUtil.getCurrentTime(formatter: nil)
        questionnaire?.name = questionNaireUUID
        
        //设置全局所有的问题的newRelationship
        for item in appDelegate.globalQuestionsList {
            item.newRelationship = questionnaire
            
            questionnaire?.addToQuestionList(item)
        }
        
        
        print("globalQuestionsList：\(appDelegate.globalQuestionsList.count)")
        
        do {
            
            
            try context?.save()
            
            QuestionUtil.clearUUID()
            
            tipAlert = UIAlertController(title: "提交成功,谢谢您的配合", message: nil, preferredStyle: .alert)
            let homeAction = UIAlertAction(title: "Home", style: .default, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            tipAlert.addAction(homeAction)
            tipAlert.addAction(cancelAction)
            self.present(tipAlert, animated: true, completion: nil)
            
        } catch  {
            print(error)
        }
     
    }
    
    override func validate() -> Bool {
        let text = textView.text
        if text?.isEmpty == true{
          QuestionUtil.showAlert(title: "please input something...", vc: self)
            return false
        }
        return true
    }
    
    //MARK: - 提交答案
    override func addQuestion() {
        
        if validate() == false{
          return
        }
      
        let q1 = Question.getQuestionById(qid: outputUUID, inManagedObjectContext: context!)
        if q1 != nil{
            question = q1
        }else{
            question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
            question.id = outputUUID
        }
        
        let name = questionDict["name"] as? String
        let quesitonStr = questionDict["question"] as? String
        let answer = textView.text
        
   
        
        question.answerTime = DateUtil.getCurrentTime(formatter: nil)
        
        question.name = name
        question.type = questionDict["type"] as? String
        question.question = quesitonStr
        question.chioceLabel = answer
        
        
        
        do {
//            try context?.save()
            print("saved data ")
            
            if !appDelegate.globalQuestionsList.isContains(item: question){
                appDelegate.globalQuestionsList.append(question)
            }
            print("Question4Controller.globalQuestionsList.count=\(appDelegate.globalQuestionsList.count) ")
            
        } catch {
            print("error:\(error)")
        }
    

    }

    override func buildUI(dict: [String : AnyObject]) {
        super.buildUI(dict: dict)
        
        questionDict = dict
        if outputUUID.isEmpty == false{
          return
        }
        outputUUID = QuestionUtil.randomSmallCaseString(length: 10)
        
        if let choices = dict["choices"]{
            arrayData = choices as! [[String : AnyObject]]
        }
        
        if textView == nil{
            textView = UITextView()
            textView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            textView.layer.borderWidth = 1
            textView.returnKeyType = .done
            textView.layer.cornerRadius = 3
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
    
    //MARK: - UINavigationController delegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is Question4Controller{
           self.navigationController?.setToolbarHidden(true, animated: false)
        }
    }
}


