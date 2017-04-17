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

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Alertable {

    @IBOutlet fileprivate weak var myTable: UITableView!
    
    fileprivate var currVideos: [Video] = []
    fileprivate var refresher: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DataManager.instance.getVideo(amount: 0)
        HUD.showProgress()
        
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
    

    
    
    @objc private func update () {
         DataManager.instance.getVideo(amount: 0)
        //HUD.show(.progress)
        refresher.endRefreshing()
        
    }
    
    private func loadMore() {
         DataManager.instance.getVideo(amount: currVideos.count)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    
        if let url = URL(string: currVideos[indexPath.row].thumbnailUrl){
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image"))
            let likes = currVideos[indexPath.row].likesCount
            cell.likesLabel.text = String(likes)
            cell.nameLabel.text = currVideos[indexPath.row].title
                           
        }
        
        if indexPath.row == currVideos.count - 2 {
           loadMore()
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = currVideos[indexPath.row].height
        let width = currVideos[indexPath.row].width
        let proportion = Double(self.view.bounds.width) / width
        
        let result = height * proportion + 10
        return CGFloat(result)
    
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = currVideos[indexPath.row].url
        let videoVC = VideoViewController()
        
        videoVC.fullVideoURL = url
        videoVC.likes = currVideos[indexPath.row].likesCount
        videoVC.title = currVideos[indexPath.row].title
        videoVC.desc = currVideos[indexPath.row].description
        videoVC.showVideo()
    }
    
}

extension SecondViewController {
    
    @objc fileprivate func gotVideo(_ notification: Notification) {
        currVideos = DataManager.instance.currentVideos
        myTable.reloadData()
        HUD.hide()
    }
    
    @objc fileprivate func didFailGetVideo (_ notification: Notification) {
        HUD.hide()
        showMessage(title: "Произошла ошибка")
    }

}
