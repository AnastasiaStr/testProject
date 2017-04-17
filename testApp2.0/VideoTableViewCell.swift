//
//  VideoTableViewCell.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        /*if ThirdViewController.userExists {
            likeButton.setImage(UIImage(named: "no_like"), for: .normal)
            likeButton.tintColor = .black
        } else {
            likeButton.setImage(UIImage(named: "like"), for: .normal)
            likeButton.tintColor = UIColor(red: 0.87, green: 87, blue: 87, alpha: 1)

        }*/
    }
    
    @IBAction func likeButton(_ sender: Any) {
    }
    


}
