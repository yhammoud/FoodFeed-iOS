//
//  HomeViewController.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/24/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    @IBAction func logoutAction(sender: UIButton) {
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = CURRENT_USER.authData.uid as String
        print(id)
        Firebase(url: "\(BASE)/users/\(id)/username").observeEventType(.Value, withBlock: { snapshot in
            self.username.text = (snapshot.value as! String)
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}