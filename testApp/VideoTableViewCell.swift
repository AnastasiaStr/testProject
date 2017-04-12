//
//  VideoTableViewCell.swift
//  testApp
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var myCell: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with text: String) {
        myCell.text = text
        
    }
       
}
