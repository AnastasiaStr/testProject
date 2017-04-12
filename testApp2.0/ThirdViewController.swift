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
        
        myButton.layer.cornerRadius = 6
        myUsername.layer.cornerRadius = 6
        myPassword.layer.cornerRadius = 6

        myUsername.delegate = self
        myPassword.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        myUsername.resignFirstResponder()
        myPassword.resignFirstResponder()
        return true
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    @IBAction func myLoginButton(_ sender: Any) {
        let username = myUsername.text
        let password = myPassword.text
        if (username == "" || password == "") {
           return
        }
        
        DoLogin(username!, password!)
    
    }
    
    func DoLogin (_ user: String, _ psw: String) {
        let url = URL(string: "https://")
    }
    

    



}
