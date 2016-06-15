//
//  LoginViewController.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/20/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if ((NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil) && (FirebaseService.firebaseService.CURRENT_USER.authData != nil)) {
            self.performSegueWithIdentifier("loggedIn", sender: nil)
            
        }
    }
    
    @IBAction func loginAction(sender: UIButton) {
        let email = self.email.text
        let password = self.password.text
        
        if (email != nil && password != nil) {
            FirebaseService.firebaseService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                (error, auth) -> Void in
                
                if (error == nil) {
                    NSUserDefaults.standardUserDefaults().setValue(auth.uid, forKey: "uid")
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                } else {
                    self.loginErrorAlert("Oops!", message: "Email and password entered were invalid.")
                    self.email.text = ""
                    self.password.text = ""
                }
            })
        } else {
            self.loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
    }
    
    func loginErrorAlert(title: String, message: String) {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }

}