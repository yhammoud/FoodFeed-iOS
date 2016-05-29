//
//  FirebaseService.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/29/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import Firebase

let BASE = "https://foodfeedapp.firebaseIO.com"
let FIREBASE_REF = Firebase(url: BASE)

var CURRENT_USER: Firebase {
    let userId = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let current_user = FIREBASE_REF.childByAppendingPath("user").childByAppendingPath(userId)
    return current_user
}