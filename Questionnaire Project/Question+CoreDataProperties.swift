//
//  Question+CoreDataProperties.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question");
    }

    @NSManaged public var answerTime: String?
    @NSManaged public var chioceLabel: String?
    @NSManaged public var chioceValue: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var question: String?
    @NSManaged public var type: String?
    @NSManaged public var value: String?
    @NSManaged public var newRelationship: Questionnaire?

}
