//
//  Utils.swift
//  testApp2.0
//
//  Created by Alexander Kravchenko on 15.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

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
    
    
}

