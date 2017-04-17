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

    var refresher: UIRefreshControl!
    
    
    fileprivate var currVideos: [Video] = []
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetVideo(_:)), name: .DidFailGetVideo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotVideo(_:)), name: .GotVideo, object: nil)
        
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
            HUD.showProgress()
            DataManager.instance.login(login: username, password: password)
        
        }
        
    }
    
    @IBAction func pressLogoutButton(_ sender: Any) {
        HUD.showProgress()
        DataManager.instance.logout()
    }
    
    
    @objc func update () {

        feedTableView.reloadData()
        refresher.endRefreshing()
        
    }
}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let url = URL(string: currVideos[indexPath.row].thumbnailUrl){
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
            let likes = currVideos[indexPath.row].likesCount
            cell.likesLabel.text = String(likes)
            cell.nameLabel.text = currVideos[indexPath.row].title
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = currVideos[indexPath.row].height
        let width = currVideos[indexPath.row].width
        let proportion = Double(self.view.bounds.width) / width
        
        let result = height * proportion + 10
        return CGFloat(result)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = currVideos[indexPath.row].url
        let videoVC = VideoViewController()
        
        videoVC.fullVideoURL = url
        videoVC.likes = currVideos[indexPath.row].likesCount
        videoVC.title = currVideos[indexPath.row].title
        videoVC.desc = currVideos[indexPath.row].description
        videoVC.showVideo()
    }
    
    
    
    
}

// MARK: - Notification handlers
extension ThirdViewController {
    
    @objc fileprivate func gotUser(_ notification: Notification) {
        if let user = DataManager.instance.currentUser {
            loginStack.isHidden = true
            logoutButton.isHidden = false
            feedTableView.isHidden = false
            self.view.endEditing(true)
            
            DataManager.instance.getFeed(token: user.token)
        }
    }
    
    @objc fileprivate func didFailGetUser(_ notification: Notification) {
        HUD.hide()
        showMessage(title: nil, message: "Incorrect login or password")
    }
    
    @objc fileprivate func logoutComplete(_ notification: Notification) {
        HUD.hide()
        logoutButton.isHidden = true
        feedTableView.isHidden = true
        loginStack.isHidden = false
    }
    
    @objc fileprivate func didFailCompleteLogout(_ notification: Notification) {
        HUD.hide()
        showMessage(title: "Mistake")
    }
    
    @objc fileprivate func gotVideo(_ notification: Notification) {
        currVideos.append(contentsOf: DataManager.instance.feedVideos)
        feedTableView.reloadData()
        HUD.hide()
    }
        
    @objc fileprivate func didFailGetVideo (_ notification: Notification) {
        HUD.hide()
        showMessage(title: "Mistake")
    }
}
