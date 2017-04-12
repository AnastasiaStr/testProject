//
//  DataManager.swift
//  testApp2.0
//
//  Created by Alexander Kravchenko on 12.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    
    private let loginUrl = "https://api.vid.me/auth/create"
    
    private init() {}
    static let instance = DataManager()
    
    
    private(set) var currentUser: User?
    
    
    func login(login: String, password: String) {
        
        let params: [String : Any] = ["username" : login, "password" : password]
        
        Alamofire.request(loginUrl, method: .post, parameters: params).responseJSON { response in
            let result = JSON(response.result.value)
            if let user = User(json: result) {
                self.currentUser = user
                NotificationCenter.default.post(name: .GotUser, object: nil)
            } else {
                NotificationCenter.default.post(name: .DidFailGetUser, object: nil)
            }
            
        }
        
    }
    
    
}
