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
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var loginStack: UIStackView!
    @IBOutlet weak var logoutButton: UIButton!
    var urlArray:[String] = ["https://d1wst0behutosd.cloudfront.net/thumbnails/14818578.jpg?v1r1491791023", "https://d1wst0behutosd.cloudfront.net/thumbnails/14861286.jpg?v1r1491945878"]
    var refresher: UIRefreshControl!
    
    var userExists = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.isHidden = true
        feedTableView.isHidden = true
        myButton.layer.cornerRadius = 6
        
        myUsername.layer.cornerRadius = 6
        myPassword.layer.cornerRadius = 6
        
        myUsername.delegate = self
        myPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotUser(_:)), name: .GotUser, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetUser(_:)), name: .DidFailGetUser, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logoutComplete(_:)), name: .CompleteLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailCompleteLogout(_:)), name: .DidFailCompleteLogout, object: nil)
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.register(VideoTableViewCell.self)
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(update), for: UIControlEvents.valueChanged)
        feedTableView.refreshControl = refresher
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        myUsername.resignFirstResponder()
        myPassword.resignFirstResponder()
        return true
    }

    
    @IBAction func myLoginButton(_ sender: Any) {
       if let username = myUsername.text, let password = myPassword.text {
            HUD.show(.progress)
            DataManager.instance.login(login: username, password: password)
        }
        
    }
    
    @IBAction func pressLogoutButton(_ sender: Any) {
        HUD.show(.progress)
        DataManager.instance.logout()
    }
    
    
    @objc func update () {
        urlArray.append("https://d1wst0behutosd.cloudfront.net/thumbnails/14832798.jpg?v1r1491836904")
        feedTableView.reloadData()
        refresher.endRefreshing()
        
    }
 

}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return urlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let url = URL(string: urlArray[indexPath.row]) {
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 274
    }
    
    
    
    
}

// MARK: - Notification handlers
extension ThirdViewController {
    

    
    @objc fileprivate func gotUser(_ notification: Notification) {
        HUD.hide()
        if let user = DataManager.instance.currentUser {
            loginStack.isHidden = true
            logoutButton.isHidden = false
            feedTableView.isHidden = false
            self.view.endEditing(true)
        }
    }
    
    @objc fileprivate func didFailGetUser(_ notification: Notification) {
        HUD.hide()
        //Я тут потом допишу разные ошибки при логине
        showMessage(title: nil, message: "Ошибка")
    }
    
    @objc fileprivate func logoutComplete(_ notification: Notification) {
        HUD.hide()
        logoutButton.isHidden = true
        feedTableView.isHidden = true
        loginStack.isHidden = false
    }
    
    @objc fileprivate func didFailCompleteLogout(_ notification: Notification) {
        HUD.hide()
        showMessage(title: "Ошибка")
    }
    
    
}
