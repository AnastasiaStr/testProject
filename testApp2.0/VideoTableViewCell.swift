//
//  VideoTableViewCell.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func likeButton(_ sender: Any) {
    }

}
