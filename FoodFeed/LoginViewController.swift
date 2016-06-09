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
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginAction(sender: UIButton) {
        if (self.email.text != nil && self.password.text != nil) {
            FirebaseService.firebaseService.BASE_REF.authUser(email.text, password: password.text, withCompletionBlock: {
                (error, auth) -> Void in
                if (error == nil) {
                    NSUserDefaults.standardUserDefaults().setValue(auth.uid, forKey: "uid")
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                    self.presentViewController(viewController, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Invalid Email or password", message: "Please enter a valid email address and password", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(defaultAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.email.text = ""
                    self.password.text = ""
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if ((NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil) && (FirebaseService.firebaseService.CURRENT_USER.authData != nil)) {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let destination = storyboard.instantiateViewControllerWithIdentifier("Home")
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }

}