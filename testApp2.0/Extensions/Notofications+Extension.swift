//
//  Notofications+Extension.swift
//  testApp2.0
//
//  Created by Anastasia on 12.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let DidFailGetUser = Notification.Name("DidFailGetUser")
    static let GotUser = Notification.Name("GotUser")
    
    static let CompleteLogout = Notification.Name("CompleteLogout")
    static let DidFailCompleteLogout = Notification.Name("DidFailCompleteLogout")
    
    static let GotVideo = Notification.Name("GotVideo")
    static let DidFailGetVideo = Notification.Name("DidFailGetVideo")
    
    static let GotFeatured = Notification.Name("GotFeatured")
    static let DidFailGetFeatured = Notification.Name("DidFailGetFeatured")
    
    static let NoInternetConnection = Notification.Name("NoInternetConnection")
    
    
}
