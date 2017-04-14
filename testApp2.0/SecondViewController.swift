//
//  SecondViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTable: UITableView!
    
    var currVideo: Video?

    
    var refresher: UIRefreshControl!
    
    var countSKA = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DataManager.instance.getVideo(amount: 0)
        HUD.show(.progress)
        
        myTable.delegate = self
        myTable.dataSource = self
        myTable.separatorInset = .zero
        myTable.separatorStyle = .none
 
        
        myTable.register(VideoTableViewCell.self)
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(SecondViewController.update), for: UIControlEvents.valueChanged)
        myTable.refreshControl = refresher
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetVideo(_:)), name: .DidFailGetVideo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotVideo(_:)), name: .GotVideo, object: nil)

        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countSKA
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let url = currVideo?.thumbnailUrl {
            cell.myImage?.af_setImage(withURL: URL(string: url)!, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
            print (url)

        }
        print ("lol")

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 274
    }
    
 
    
    func update () {
        
        myTable.reloadData()
        refresher.endRefreshing()
  
    }
}

extension SecondViewController {
    
    @objc fileprivate func gotVideo(_ notification: Notification) {
        print ("lola")
        currVideo = DataManager.instance.currentVideo
        print (currVideo?.thumbnailUrl)
        countSKA = countSKA + 1
        myTable.reloadData()
        HUD.hide()
        print (countSKA)
        print ("azaza")
    }
    
    @objc fileprivate func didFailGetVideo (_ notification: Notification) {
    }

}
