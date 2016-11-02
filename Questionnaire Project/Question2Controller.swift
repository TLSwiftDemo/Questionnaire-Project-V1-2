//
//  Question2Controller.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import CoreData

class Question2Controller: DataViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    var arrayData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    //问题的字典数据
    var questionDict:[String:AnyObject]!
    //选中的答案 多选
    var selectedQuestionArray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func addQuestion() {
        
       
        
        if outputUUID.isEmpty
        {
            return
        }
        
        let question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
        
        let name = questionDict["name"] as? String
        let quesitonStr = questionDict["question"] as? String
        
        var answerLabel = ""
        var answerValue = ""
        
        //拼接多选的答案
        for item in selectedQuestionArray{
            let label = item["label"] as? String
            let value = item["value"] as? Int
            
            answerLabel.append(label!)
            answerLabel.append(";")
            answerValue.append("\(value!)")
            answerValue.append(";")
        }
        
        
        
        question.id = outputUUID
        question.answerTime = DateUtil.getCurrentTime(formatter: nil)
        
        
        question.name = name
        question.type = questionDict["type"] as? String
        question.question = quesitonStr
        question.chioceLabel = answerLabel
        question.chioceValue = "\(answerValue)"
        
        do {
            try context?.save()
            
            if !appDelegate.globalQuestionsList.isContains(item: question){
                appDelegate.globalQuestionsList.append(question)
            }
            
        } catch {
            print("error:\(error)")
        }
        
    }

    
    override func buildUI(dict:[String:AnyObject]) -> Void {
        
        questionDict = dict
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

extension Question2Controller{
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
        
        
        
        let item = arrayData[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
            selectedQuestionArray.removeObj(item: item as AnyObject)
        }else{
            cell?.accessoryType = .checkmark
            selectedQuestionArray.append(item)
        }
        
        
    }
}




