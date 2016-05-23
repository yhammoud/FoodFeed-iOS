//
//  User.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/21/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var userID: Int!
    var userFName: String!
    var userLName: String!
    var userEmail: String!
    var userDOB: NSDate!
    var userCreatedAt: NSDate!
    var userNumOfPosts: Int!
    var userNumOfFollowers: Int!
    var userNumOfFollowings: Int!
    
    init(userID: Int, userFName: String, userLName: String, userEmail: String,  userDOB: NSDate, userCreatedAt: NSDate,
         userIsActive: Bool, userNumOfPosts: Int, userNumOfFollowers: Int, userNumOfFollowings: Int) {
        super.init()
        self.userID = userID
        self.userFName = userFName
        self.userLName = userLName
        self.userEmail = userEmail
        self.userDOB = userDOB
        self.userCreatedAt = userCreatedAt
        self.userNumOfPosts = userNumOfPosts
        self.userNumOfFollowers = userNumOfFollowers
        self.userNumOfFollowings = userNumOfFollowings
    }
    
    func userIDGetter() -> Int {
        return self.userID
    }
    
    func userIDSetter(id: Int) -> Void {
        self.userID = id
    }
    
    func userFNameGetter() -> String {
        return self.userFName
    }
    
    func userFNameSetter(fName: String) -> Void {
        self.userFName = fName
    }
    
    func userLNameGetter() -> String {
        return self.userLName
    }
    
    func userLNameSetter(lName: String) -> Void {
        self.userLName = lName
    }
    
    func userEmailGetter() -> String {
        return self.userEmail
    }
    
    func userEmailSetter(email: String) -> Void {
        self.userEmail = email
    }
    
    func userDOBGetter() -> NSDate {
        return self.userDOB
    }
    
    func userDOBSetter(dob: NSDate) -> Void {
        self.userDOB = dob
    }
    
    func userCreatedAtGetter(date: NSDate) -> NSDate {
        return self.userCreatedAt
    }
    
    func userCreatedAtSetter(date: NSDate) -> Void {
        self.userCreatedAt = date
    }
    
    func userNumOfPostsGetter() -> Int {
        return self.userNumOfPosts
    }
    
    func userNumOfPostsSetter(numOfPosts: Int) -> Void {
        self.userNumOfPosts = numOfPosts
    }
    
    func userNumOfFollowersGetter() -> Int {
        return self.userNumOfFollowers
    }
    
    func usernUmOfFollowersSetter(numOfFollowers: Int) -> Void {
        self.userNumOfFollowers = numOfFollowers
    }
    
    func userNumOfFollowingsGetter() -> Int {
        return self.userNumOfFollowings
    }
    
    func userNumOfFollowingsSetter(numOfFollowings: Int) -> Void {
        self.userNumOfFollowings = numOfFollowings
    }
    
    
    override var description: String {
        return "User ID: \(userID)" +
            "User Name: \(userFName + userLName)" +
            "User DOB: \(userDOB)" +
            "User since: \(userCreatedAt)" +
            "User's # posts: \(userNumOfPosts)" +
            "User's # followers: \(userNumOfFollowers)" +
            "User's # followings: \(userNumOfFollowings)"
    }
    
}