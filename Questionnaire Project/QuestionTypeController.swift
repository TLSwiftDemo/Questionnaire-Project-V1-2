//
//  QuestionTypeController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/9.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class QuestionTypeController: BaseController,UITableViewDelegate,UITableViewDataSource {

    
    var tableView:UITableView!
    
    var arrayData = [QuestionType.singleOption,QuestionType.multiOption,QuestionType.numeric,QuestionType.text]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.titlelb.text = "Select type of question"
        self.navigationItem.title = "Select type of question"
        
        tableView = UITableView()
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(64)
            make.bottom.equalTo(0)
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
          cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = arrayData[indexPath.row].rawValue
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellType = arrayData[indexPath.row]
        switch cellType {
        case .singleOption:
            getQ1Data()
        case .multiOption:
            getQ2Data()
            break
        case .numeric:
            getQ3Data()
            break
        case .text:
            QuestionUtil.showAlert(title: "is building...", vc: self)
            break
       
        }
    }
    
    //MARK: - 请求不同问题类型的数据
    
    func getQ1Data() -> Void {
        let array = Question.splitCountByAnswer(type: QuestionType.singleOption.rawValue, context: context!)
        let report = ReportController()
        report.arrayData = array
        report.xTitle = "Answer"
        report.yTitle = "Count"
        self.navigationController?.pushViewController(report, animated: true)
    }
    
    func getQ3Data() -> Void {
        let array = Question.splitCountByAnswer(type: QuestionType.numeric.rawValue, context: context!)
        let report = ReportController()
        report.arrayData = array
        report.xTitle = "device"
        report.yTitle = "numbers"
        self.navigationController?.pushViewController(report, animated: true)
    }
    
    func getQ2Data() -> Void {
        let array = Question.splitCountByAnswer(type: QuestionType.multiOption.rawValue, context: context!)
        let report = ReportController()
        report.arrayData = array
        report.xTitle = "Answer"
        report.yTitle = "Count"
        report.descString = "1=Introduction to COMP327; 2=Introduction to Core Data; 3=Swift Intro; 4=The Internet of Things"
        self.navigationController?.pushViewController(report, animated: true)
    }
 

}
