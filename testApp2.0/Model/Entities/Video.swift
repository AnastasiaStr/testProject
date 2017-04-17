//
//  Video.swift
//  testApp2.0
//
//  Created by Anastasia on 13.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Video {
    let id: String
    let url: String
    let title: String
    let description: String
    let likesCount: Int
    let thumbnailUrl: String
    let height: Double
    let width: Double
}

extension Video {
    init?(json: JSON) {
        guard let videoId = json["video_id"].string,
            let url = json["complete_url"].string,
            let title = json["title"].string,
            let description = json["description"].string,
            let likesCount = json["likes_count"].int,
            let thumbnailUrl = json["thumbnail_url"].string,
            let height = json["height"].double,
            let width = json["width"].double else {return nil}
        
        self.id = videoId
        self.url = url.replacingOccurrences(of: "\\", with: "")
        self.title = title
        self.description = description
        self.likesCount = likesCount
        self.thumbnailUrl = thumbnailUrl.replacingOccurrences(of: "\\", with: "")
        self.height = height
        self.width = width
    }
}
