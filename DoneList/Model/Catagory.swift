//
//  Catagory.swift
//  DoneList
//
//  Created by Farhan Qazi on 4/17/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseUI
import FirebaseCore


class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    @objc dynamic var userid: String = "" // authDataResult?.user.uid <- could not be used. Errored out
    let items = List<Item>()
}
