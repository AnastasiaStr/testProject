//
//  SecondViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import AlamofireImage

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    
    var urlArray:[String] = ["https://d1wst0behutosd.cloudfront.net/thumbnails/14818578.jpg?v1r1491791023", "https://d1wst0behutosd.cloudfront.net/thumbnails/14861286.jpg?v1r1491945878"]
    
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTable.delegate = self
        myTable.dataSource = self
        myTable.separatorInset = .zero
        myTable.separatorStyle = .none
 
        
        myTable.register(VideoTableViewCell.self)
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresher.addTarget(self, action: #selector(SecondViewController.update), for: UIControlEvents.valueChanged)
        myTable.addSubview(refresher)
        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let url = URL(string: urlArray[indexPath.row]) {
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VideoTableViewCell.hight
    }
    
 
    
    func update () {
        urlArray.append("https://d1wst0behutosd.cloudfront.net/thumbnails/14832798.jpg?v1r1491836904")
        myTable.reloadData()
        refresher.endRefreshing()
  
    }
}
