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
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthday: UITextField!
    
    
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
        
        if (isValidEmail(self.email.text!)) {
            self.ref.createUser(email.text, password: password.text, withValueCompletionBlock: { error, result in
                if (error == nil) {
                    let usersRef = self.ref.childByAppendingPath("users")
                    let user = ["id": result["uid"]!, "username": self.username.text!, "email":self.email.text!, "first name": self.firstName.text!, "last name": self.lastName.text!, "dob": self.birthday.text!, "created_at": NSDate().description, "posts": 0, "followers": 0, "followings": 0, "is_active": false]
                    let userRef =  usersRef.childByAppendingPath(result["uid"] as! String)
                    userRef.setValue(user)
                    self.ref.authUser(self.email.text, password: self.password.text, withCompletionBlock: { (error, auth) -> Void in
                        if (error == nil) {
                            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                            self.presentViewController(viewController, animated: true, completion: nil)

                        } else {
                            print(error.description)
                            for textField in textFields {
                                textField.text = ""
                            }
                        }
                    })
                } else {
                    print(error.description)
                    for textField in textFields {
                        textField.text = ""
                    }
                }
            })
        } else {
            let alert = UIAlertController(title: "Invalid Email or password", message: "Please enter a valid email address and password", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            for textField in textFields {
                textField.text = ""
            }
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
