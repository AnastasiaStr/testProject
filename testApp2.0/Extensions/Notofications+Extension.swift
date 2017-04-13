//
//  Notofications+Extension.swift
//  testApp2.0
//
//  Created by Alexander Kravchenko on 12.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let DidFailGetUser = Notification.Name("DidFailGetUser")
    static let GotUser = Notification.Name("GotUser")
    
    static let CompleteLogout = Notification.Name("CompleteLogout")
    static let DidFailCompleteLogout = Notification.Name("DidFailCompleteLogout")
    
    
}
