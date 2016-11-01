//
//  Questionnaire+CoreDataProperties.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import CoreData


extension Questionnaire {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questionnaire> {
        return NSFetchRequest<Questionnaire>(entityName: "Questionnaire");
    }

    @NSManaged public var time: String?
    @NSManaged public var name: String?
    @NSManaged public var questionList: NSSet?

}

// MARK: Generated accessors for questionList
extension Questionnaire {

    @objc(addQuestionListObject:)
    @NSManaged public func addToQuestionList(_ value: Question)

    @objc(removeQuestionListObject:)
    @NSManaged public func removeFromQuestionList(_ value: Question)

    @objc(addQuestionList:)
    @NSManaged public func addToQuestionList(_ values: NSSet)

    @objc(removeQuestionList:)
    @NSManaged public func removeFromQuestionList(_ values: NSSet)

}
