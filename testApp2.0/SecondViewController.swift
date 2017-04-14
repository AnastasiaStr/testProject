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
    
    var currVideos: [Video?] = []
    
    var refresher: UIRefreshControl!
    
    var count = 0
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if count != 0 {
            if let url = currVideos[indexPath.row]?.thumbnailUrl {
                cell.myImage?.af_setImage(withURL: URL(string: url)!, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
            }
                
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if count != 0 {
            let height = currVideos[indexPath.row]?.height
            let width = currVideos[indexPath.row]?.width
            let proportion = 375/width!
            
            
            let result = height!*proportion + 50
            print(height, width, proportion, result)
            return CGFloat(result)
        }
        
        
        return 0
    }
    
 
    
    func update () {
        
        myTable.reloadData()
        refresher.endRefreshing()
  
    }
}

extension SecondViewController {
    
    @objc fileprivate func gotVideo(_ notification: Notification) {
        print ("lola")
        currVideos = DataManager.instance.currentVideos
        count = count + 10
        myTable.reloadData()
        HUD.hide()
        print (count)
        print ("azaza")
    }
    
    @objc fileprivate func didFailGetVideo (_ notification: Notification) {
    }

}
