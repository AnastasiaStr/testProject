//
//  Utils.swift
//  testApp2.0
//
//  Created by Anastasia on 15.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import SystemConfiguration

struct Utils {
    
    static func cropImage(_ image: UIImage, width: CGFloat) -> UIImage {
        var imageWidth = image.size.width
        var imageHeight = image.size.height
        
        if imageWidth > width || imageHeight > width {
            if imageWidth > imageHeight {
                let scale = width / imageWidth
                imageWidth = width
                imageHeight = imageHeight * scale
            } else {
                let scale = width / imageHeight
                imageHeight = width
                imageWidth = imageWidth * scale
            }
        }
        
        let newWidth = CGFloat(imageWidth)
        let newHeight = CGFloat(imageHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    static var isInternetAvailable: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}

