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
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthday: UITextField!
    
    @IBAction func usernameEditAction(sender: UITextField) {
        Firebase(url: "\(BASE)/usernames/\(self.username.text!)").observeEventType(.Value, withBlock: { snapshot in
            if (snapshot.exists()) {
                self.username.textColor = UIColor.redColor()
                self.signupErrorAlert("Oops!", message: "This username is already used. Please try a different username.")
            }
        })
    }
    
    @IBAction func editBirthday(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        let datePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width) - (100), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(SignupViewController.doneButton), forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(SignupViewController.handleDatePicker), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthday.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func doneButton(sender:UIButton)
    {
        birthday.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        let textFields = [self.email, self.username, self.password, self.firstName, self.lastName, self.birthday]
        
        var nilFields: Bool = false
        for field in textFields {
            if (field.text == nil) {
                nilFields = true
                return
            }
        }
        
        if (isValidEmail(self.email.text!) && !nilFields && self.username.textColor != UIColor.redColor()) {
            FirebaseService.firebaseService.BASE_REF.createUser(email.text, password: password.text, withValueCompletionBlock: { error, result in
                if (error == nil) {
                    let usersRef = FirebaseService.firebaseService.BASE_REF.childByAppendingPath("users").childByAppendingPath(result["uid"] as! String)
                    let userNameRef = FirebaseService.firebaseService.BASE_REF.childByAppendingPath("usernames").childByAppendingPath(self.username.text)
                    let usernameDict = ["id": result["uid"]!]
                    userNameRef.setValue(usernameDict)
                    let user = ["id": result["uid"]!, "username": self.username.text!, "email":self.email.text!, "first name": self.firstName.text!, "last name": self.lastName.text!, "dob": self.birthday.text!, "created_at": NSDate().description, "posts": 0, "followers": 0, "followings": 0, "is_active": false]
                    usersRef.setValue(user)
                    FirebaseService.firebaseService.BASE_REF.authUser(self.email.text, password: self.password.text, withCompletionBlock: { (error, auth) -> Void in
                        if (error == nil) {
                            NSUserDefaults.standardUserDefaults().setValue(auth.uid, forKey: "uid")
                            self.performSegueWithIdentifier("signUpSuccess", sender: nil)
                        }
                    })
                } else {
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Please try again.")
                }
            })
        } else {
            print("Please fill in all the fields")
            signupErrorAlert("Oops!", message: "All fields are required. Please fill in all the fields above")
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
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
}
