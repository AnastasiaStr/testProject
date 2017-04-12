//
//  VideoTableViewCell.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    static let hight: CGFloat = 185

    @IBOutlet weak var myPlayButton: UIButton!
    @IBOutlet weak var myImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        myPlayButton.layer.zPosition = 1
        selectionStyle = .none
    }
    

}
