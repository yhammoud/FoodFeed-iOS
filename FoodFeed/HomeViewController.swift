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
    var ref = Firebase(url: "https://foodfeedapp.firebaseIO.com")
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        ref.
        super.viewDidLoad()
    }
    
}