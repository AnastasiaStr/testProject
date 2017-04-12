//
//  ThirdViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import PKHUD

class ThirdViewController: UIViewController, UITextFieldDelegate, Alertable {

    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myButton.layer.cornerRadius = 6
        myUsername.layer.cornerRadius = 6
        myPassword.layer.cornerRadius = 6

        myUsername.delegate = self
        myPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotUser(_:)), name: .GotUser, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetUser(_:)), name: .DidFailGetUser, object: nil)
        
        
        
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
        if let username = myUsername.text, let password = myPassword.text {
            HUD.show(.progress)
            DataManager.instance.login(login: username, password: password)
        }
    }
    
    func DoLogin (_ user: String, _ psw: String) {
        let url = URL(string: "https://")
    }


}

// MARK: - Notification handlers
extension ThirdViewController {
    
    @objc fileprivate func gotUser(_ notification: Notification) {
        HUD.hide()
        if let user = DataManager.instance.currentUser {
            loginLabel.text = "Вы нежно вошли как \(user.login)"
        }
        
    }
    
    @objc fileprivate func didFailGetUser(_ notification: Notification) {
        HUD.hide()
        //Я тут потом допишу разные ошибки при логине
        showMessage(title: nil, message: "Ошибка")
    }
    
}
