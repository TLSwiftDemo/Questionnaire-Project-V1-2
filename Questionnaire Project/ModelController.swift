//
//  ModelController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/10/31.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource,NN_DataViewControllerProtocol {

    var pageData: [[String:AnyObject]] = [[String:AnyObject]]()

    var controllerArray = [DataViewController]()
    weak var pageViewController:UIPageViewController!
    
    override init() {
        super.init()
        
        let questionDict = QuestionModel.getJsonData()
        
        if let questions = questionDict!["questions"] {
            pageData = questions as! [[String:AnyObject]]
        }
      
        let q1 = Question1Controller()
        q1.delegate = self
        let q2 = Question2Controller()
        q2.delegate=self
        let q3 = Question3Controller()
        q3.delegate = self
        let q4 = Question4Controller()
        q4.delegate = self
        controllerArray.append(q1)
        controllerArray.append(q2)
        controllerArray.append(q3)
        controllerArray.append(q4)
        
        // Create the data model.
     
    }

    func viewControllerAtIndex(_ index: Int) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = controllerArray[index]
       
        
        let dict = self.pageData[index]
        dataViewController.initQuestion(dict: dict)
        
        if let title = dict["name"] {
          dataViewController.dataObject = title as! String
        }
        
      
        return dataViewController
        
        
    }

    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        
        
        var index = 0
        for item in pageData{
          let name = item["name"] as! String
            if name == viewController.dataObject{
              return index
            }
            index = index + 1
        }
        
        
        
        
        return index
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }

}

extension ModelController{
  //MARK: - NN_DataViewControllerProtocol
    func nextAction(dataViewController: DataViewController?) {
        let index = self.indexOfViewController(dataViewController!)
        
        let currentController = self.viewControllerAtIndex(index)
        var viewControllers:[UIViewController]
        
        if currentController == nil{
         return
        }
        
        let nextController = self.pageViewController(pageViewController, viewControllerAfter: currentController!)
        
        guard let nextVC = nextController else{
            return
        }
        
        viewControllers  = [nextVC]
        self.pageViewController?.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
    
    func prevAction(dataViewController: DataViewController?) {
        let index = self.indexOfViewController(dataViewController!)
        
        let currentController = self.viewControllerAtIndex(index)
        var viewControllers:[UIViewController]
        
        if currentController == nil{
           return
        }
        
        let prevController = self.pageViewController(pageViewController, viewControllerBefore: currentController!)
        
        guard let previousController = prevController else{
            return
        }
        
        
        
        
        
        viewControllers  = [previousController]
        self.pageViewController?.setViewControllers(viewControllers, direction: .reverse, animated: true, completion: nil)
    }
}

