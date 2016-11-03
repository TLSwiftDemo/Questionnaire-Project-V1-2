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

class ResultController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var arrayData:[Questionnaire] = [Questionnaire]()
    
     var context:NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    



    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Questionnaire"
        self.titlelb.text = "Questionnaire"
        requestData()
        
        initView()
    }
    
    func requestData() -> Void {
        let request = NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
        
        let sortDescritor = NSSortDescriptor(key: "time", ascending: false, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        request.sortDescriptors = [sortDescritor]
        
      
        
        do {
            if let results = (try? context?.fetch(request)){
                arrayData = results!
            }
        } catch {
            
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
            make.top.equalTo(64)
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
        
        let questionnaire = arrayData[indexPath.row]
        
        let detail = DetailController()
        detail.questionnaire = questionnaire
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
          
            let questionnaire = arrayData[indexPath.row]
            arrayData.removeObj(item: questionnaire)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            Questionnaire.deleteQuestionnaire(questionnaire: questionnaire, inContextObjectContext: context!)
            
        }
    }
    
 
    
   

}
