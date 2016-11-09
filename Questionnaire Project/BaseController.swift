//
//  BaseController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/3.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import CoreData

class BaseController: UIViewController {
    
    var titlelb:UILabel!
    var context:NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        
       

        let topView = UIView()
        self.view.addSubview(topView)
        topView.backgroundColor = COLOR_BG
        
        topView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(64)
        }
        
        let backImg = UIImage(named:"back6")!
        let btn = UIButton(type: .system)
        btn.setImage(backImg, for: .normal)
        topView.addSubview(btn)
        
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        btn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(topView.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        titlelb = UILabel()
        titlelb.font = UIFont.boldSystemFont(ofSize: 20)
        titlelb.textAlignment = .center
        topView.addSubview(titlelb)
        
        
        titlelb.snp.makeConstraints { (make) in
            make.center.equalTo(topView.snp.center)
        }
        
        
        
    }
    
    func back() -> Void {
        self.navigationController?.popViewController(animated: true)
    }


 

}
