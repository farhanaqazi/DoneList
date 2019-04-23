//
//  Item.swift
//  DoneList
//
//  Created by Farhan Qazi on 4/17/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    private var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

