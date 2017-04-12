//
//  ThirdViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myButton.layer.cornerRadius = 10
        //myButton.layer.frame = 4

        //myUsername.delegate = self
        //myPassword.delegate = self
    }
    
    @IBAction func myLoginButton(_ sender: Any) {
        
        
        let username = myUsername.text
        let password = myPassword.text
        print(username, password)
        
    }
    



}
