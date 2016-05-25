//
//  SignupViewController.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/20/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class SignupViewController: UIViewController {
    var ref = Firebase(url: "https://foodfeedapp.firebaseIO.com")
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUpAction(sender: UIButton) {
        if (isValidEmail(self.email.text!)) {
            self.ref.createUser(email.text, password: password.text) { (error: NSError!) in
                if (error == nil) {
                    print("no error on creating user")
                    self.ref.authUser(self.email.text, password: self.password.text, withCompletionBlock: { (error, auth) -> Void in
                        if (error == nil) {
                            let userRef = self.ref.childByAppendingPath("user")
                            let user: NSDictionary = ["username":self.username.text!,"email":self.email.text!]
                            userRef.setValue(user)
                        }
                    })
                }
            }
        } else {
            let alert = UIAlertView(title: "Invalid Email", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            email.text = ""
            username.text = ""
            password.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
}
