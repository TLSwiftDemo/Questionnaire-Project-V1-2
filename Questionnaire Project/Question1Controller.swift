//
//  Question1Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class Question1Controller: DataViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView:UITableView!
    var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    //问题的字典数据
    var questionDict:[String:AnyObject]!
    //选中的答案 单选
    var selectedQuestionDict:[String:AnyObject]?
 

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
   
    override func addQuestion() {
        
        guard let selectedDict = selectedQuestionDict else {
            return
        }
        if outputUUID.isEmpty
        {
            return
        }
        let q1 = Question.getQuestionById(qid: outputUUID, inManagedObjectContext: context!)
        if q1 != nil{
            self.question = q1
        }else{
            self.question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
            question.id = outputUUID
        }
        
       
        
        let name = questionDict["name"] as? String
        let quesitonStr = questionDict["question"] as? String
        let answerLabel = selectedDict["label"] as? String
        let answerValue = selectedDict["value"] as? Int
        
        
        question.answerTime = DateUtil.getCurrentTime(formatter: nil)
        
        
        question.name = name
        question.type = questionDict["type"] as? String
        question.question = quesitonStr
        question.chioceLabel = answerLabel
        question.chioceValue = "\(answerValue)"
        
        do {
            try context?.save()
            
            if !appDelegate.globalQuestionsList.isContains(item:question){
                appDelegate.globalQuestionsList.append(question)
            }
            
        } catch {
            print("error:\(error)")
        }

    }
 

    override func buildUI(dict:[String:AnyObject]) -> Void {
        
        questionDict = dict
        if outputUUID.isEmpty == false{
            return
        }
        outputUUID = QuestionUtil.randomSmallCaseString(length: 5)
        
        if let choices = dict["choices"]{
            arrayData = choices as! [[String : AnyObject]]
        }
        
        
        if tableView == nil{
            tableView = UITableView()
            tableView.backgroundColor = UIColor.clear
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            self.contentView.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(self.questionLb.snp.bottom).offset(5)
                make.bottom.equalTo(0)
            }
        }
        
    }

}

extension Question1Controller{
  //MARK: - UITableview dataSource
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
           cell = QuestionCell(style: .default, reuseIdentifier: cellId)
        }
        
        let dict = arrayData[indexPath.row]
        (cell as! QuestionCell).setDataSource(dict: dict)
        
        cell?.accessoryType = .none
        
        return cell!
    }
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = .checkmark
        
        
        let dict = arrayData[indexPath.row]
        selectedQuestionDict = dict
        
    }
}

