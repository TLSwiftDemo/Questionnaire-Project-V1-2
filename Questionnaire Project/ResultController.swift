//
//  ResultController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class ResultController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var arrayData:[Questionnaire] = [Questionnaire]()
    
     var context:NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        requestData()
        
        initView()
        
    }
    
    func requestData() -> Void {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
//        request.predicate = NSPredicate(format: "name = %@", "")
        
        do {
            if let results = (try? context?.fetch(request)){
              
                arrayData = results!
            }
        } catch  {
            
        }
        
        
    }
    
    func initView() -> Void {
        tableView = UITableView()
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

    
    //MARK: - UItableview dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil{
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        let questionnaire = arrayData[indexPath.row]
        cell?.textLabel?.text = questionnaire.name
        
        cell?.detailTextLabel?.text = questionnaire.time
    
        cell?.accessoryType = .detailDisclosureButton
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
 

}
