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
    
    var currVideos: [Video] = []
    
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
        refresher.addTarget(self, action: #selector(update), for: UIControlEvents.valueChanged)
        myTable.refreshControl = refresher
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetVideo(_:)), name: .DidFailGetVideo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotVideo(_:)), name: .GotVideo, object: nil)

        
    }
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard count != 0 else { return UITableViewCell() }
    
        if let url = URL(string: currVideos[indexPath.row].thumbnailUrl){
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image2"))
            let likes = currVideos[indexPath.row].likesCount
            cell.likesLabel.text = String(likes)
                
        }
        
        if indexPath.row == currVideos.count - 1 {
           loadMore()
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if count != 0 {
            let height = currVideos[indexPath.row].height
            let width = currVideos[indexPath.row].width
            let proportion = 375 / width
            
            let result = height * proportion + 50
            return CGFloat(result)
        }
        
        
        return 0
    }
    
 
    
    @objc private func update () {
        DataManager.instance.getVideo(amount: 0)
        //HUD.show(.progress)
        refresher.endRefreshing()
  
    }
    
    private func loadMore() {
        DataManager.instance.getVideo(amount: currVideos.count)
    }
}

extension SecondViewController {
    
    @objc fileprivate func gotVideo(_ notification: Notification) {
        currVideos = DataManager.instance.currentVideos
        count = count + 10
        myTable.reloadData()
        HUD.hide()
    }
    
    @objc fileprivate func didFailGetVideo (_ notification: Notification) {
    }

}
