//
//  StartController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class StartController: UIViewController {

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
    }
    
    func startAction() -> Void {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        

        let rootController = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        
        
        self.navigationController?.pushViewController(rootController, animated: true)
    }

  

}
