//
//  LoginViewController.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/20/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    var ref = Firebase(url: "https://foodfeedapp.firebaseIO.com")
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginAction(sender: UIButton) {
        self.ref.authUser(email.text, password: password.text, withCompletionBlock: {
            (error, auth) -> Void in
            if (error == nil) {
                print("no error on logging in user")
                
                
            }
        })
    }
    
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
    
}