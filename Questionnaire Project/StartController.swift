//
//  StartController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

var globalQuestionDict:[String:AnyObject]?

class StartController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var spinner:UIActivityIndicatorView!
    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        context = appDelegate.persistentContainer.viewContext
        initView()
    }
    
    func initView() -> Void
    {
        let label=UILabel(frame: CGRect(x: 40, y: 45, width: 500, height: 300))
        label.text="Questionnaire"
        self.view.addSubview(label)
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = UIColor.red
        
        
        let btn = createBtn(title: "Start")
        btn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        self.view.addSubview(btn)
    
        
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        // btn of Result
        let resultBtn = createBtn(title: "Result")
        resultBtn.addTarget(self, action: #selector(resultAction), for: .touchUpInside)
        self.view.addSubview(resultBtn)
        
        resultBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn.snp.centerX)
            make.top.equalTo(btn.snp.bottom).offset(10)
            make.size.equalTo(btn.snp.size)
        }
        
        //btn of Report
        let reportBtn = createBtn(title: "Report")
        reportBtn.addTarget(self, action: #selector(reportAction(btn:)), for: .touchUpInside)
        self.view.addSubview(reportBtn)
        
        reportBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn.snp.centerX)
            make.top.equalTo(resultBtn.snp.bottom).offset(10)
            make.size.equalTo(btn.snp.size)
        }
        

        spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .gray
        self.view.addSubview(spinner)
        
        spinner.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }

    }
    
    func reportAction(btn:UIButton) -> Void {
        let typeVc = QuestionTypeController()
//        let reportVc = BarsExample()
        self.navigationController?.pushViewController(typeVc, animated: true)
    }
    
    func createBtn(title:String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.backgroundColor = UIColor.groupTableViewBackground
        return btn
    }
    
    func resultAction() -> Void {
        let result = ResultController()
        self.navigationController?.pushViewController(result, animated: true)
    }
    
    func startAction() -> Void {
        
        spinner.startAnimating()
        
       
        appDelegate.globalQuestionsList.removeAll()
        context?.reset()
        
        
        
        if QuestionModel.getJsonFromCatch() != nil {
            globalQuestionDict = QuestionModel.getJsonFromCatch()
            self.spinner.stopAnimating()
             self.skipAction()
        }else{
            QuestionModel.getJsonDataFromServer(completionHandler: { (dict) in
                globalQuestionDict = dict
                self.skipAction()
                self.spinner.stopAnimating()
                
                
            }) { (error) in
                self.spinner.stopAnimating()
            }
        }
        
        
    }
    

    func skipAction() -> Void {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let rootController = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        
        self.navigationController?.pushViewController(rootController, animated: true)
    }
  

}
