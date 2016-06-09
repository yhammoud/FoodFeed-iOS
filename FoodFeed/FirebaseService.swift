//
//  FirebaseService.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/29/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    static let firebaseService = FirebaseService()
    static let BASE = "https://foodfeedapp.firebaseIO.com"
    private let _BASE_REF = Firebase(url: "\(BASE)")
    private let _USER_REF = Firebase(url: "\(BASE)/users")
    private let _USERNAME_REF = Firebase(url: "\(BASE)/usernames")
    private let _POST_REF = Firebase(url: "\(BASE)/posts")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var USERNAME_REF: Firebase {
        return _USERNAME_REF
    }
    
    var CURRENT_USER: Firebase {
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let current_user = BASE_REF.childByAppendingPath("user").childByAppendingPath(userId)
        return current_user
    }
    
    
}

