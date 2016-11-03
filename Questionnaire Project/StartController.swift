//
//  StartController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

var globalQuestionDict:[String:AnyObject]?

class StartController: UIViewController {

    
    var spinner:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
    }
    
    func initView() -> Void
    {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        
        let resultBtn = UIButton()
        resultBtn.setTitle("Result", for: .normal)
        resultBtn.setTitleColor(UIColor.red, for: .normal)
        resultBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        resultBtn.addTarget(self, action: #selector(resultAction), for: .touchUpInside)
        self.view.addSubview(resultBtn)
        
        resultBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn.snp.centerX)
            make.top.equalTo(btn.snp.bottom).offset(10)
            make.size.equalTo(btn.snp.size)
        }
        
        
        spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .gray
        self.view.addSubview(spinner)
        
        spinner.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }

    }
    
    func resultAction() -> Void {
        let result = ResultController()
        self.navigationController?.pushViewController(result, animated: true)
    }
    
    func startAction() -> Void {
        
        spinner.startAnimating()
        
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
