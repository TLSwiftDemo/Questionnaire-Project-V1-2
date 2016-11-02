//
//  DetailController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class DetailController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var arrayData:[Question] = [Question]()
    var context:NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        
        requestData()
        initView()
    }
    
    func requestData() -> Void {
        let request = NSFetchRequest<Question>(entityName: "Question")
//        request.predicate = NSPredicate(format: "name = %@", "")
        
        do {
            if let results = (try? context?.fetch(request)){
                
                arrayData = results!
            }
        } catch  {
            print(error)
        }
        
        
    }
    
    func initView() -> Void {
        tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

    
    //MARK: - UITableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
         cell = AnswerCell(style: .default, reuseIdentifier: cellId)
        }
        
        if arrayData.count>0{
            let question = arrayData[indexPath.row]
            (cell as! AnswerCell).setDataSource(question: question)
        }
        
        return cell!
    }
   

}
