//
//  User.swift
//  testApp2.0
//
//  Created by Anastasia on 12.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation
import SwiftyJSON


struct User {
    let id: String
    let login: String
    var photoURL: String?
    let token: String
}

extension User {
    init?(json: JSON) {
        guard let userId = json["user"]["user_id"].string,
                let username = json["user"]["username"].string,
            let token = json["auth"]["token"].string else {return nil}
        
        self.id = userId
        self.login = username
        self.token = token
        if let imageUrl = json["auth"]["avatar"].string {
            self.photoURL = imageUrl
        }
    }
}


