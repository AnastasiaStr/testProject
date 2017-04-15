//
//  Video.swift
//  testApp2.0
//
//  Created by Alexander Kravchenko on 13.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Video {
    let id: String
    let url: String
    let title: String
    let likesCount: String
    let thumbnailUrl: String
    let height: Double
    let width: Double
}

extension Video {
    init?(json: JSON) {
        print (json["video_id"].string)
        guard let videoId = json["video_id"].string,
            let url = json["complete_url"].string,
            let title = json["title"].string,
            let likesCount = json["likes_count"].int,
            let thumbnailUrl = json["thumbnail_url"].string,
            let height = json["height"].double,
            let width = json["width"].double else {return nil}
        
        self.id = videoId
        self.url = url.replacingOccurrences(of: "\\", with: "")
        self.title = title
        self.likesCount = String(likesCount)
        self.thumbnailUrl = thumbnailUrl.replacingOccurrences(of: "\\", with: "")
        self.height = height
        self.width = width
    }
}
