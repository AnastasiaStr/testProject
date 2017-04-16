//
//  ViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class FeaturedViewController: UIViewController, Alertable {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var currVideos: [Video] = []
    fileprivate var refresher: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        
        tableView.register(VideoTableViewCell.self)
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(update), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refresher
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFailGetVideos(_:)), name: .DidFailGetFeatured, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotVideos(_:)), name: .GotFeatured, object: nil)

      
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if currVideos.isEmpty {
            DataManager.instance.getFeatured(amount: 0)
            HUD.show(.progress)
        }
    }
    
    
//MARK: - Private methods
    
    @objc private func update () {
        DataManager.instance.getFeatured(amount: 0)
        refresher.endRefreshing()
        
    }
    
    fileprivate func loadMore() {
        DataManager.instance.getFeatured(amount: currVideos.count)
    }
    
}



extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let url = URL(string: currVideos[indexPath.row].thumbnailUrl){
            cell.myImage?.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder_image2"))
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



extension FeaturedViewController {
    
    @objc fileprivate func gotVideos(_ notification: Notification) {
        currVideos = DataManager.instance.featuredVideos
        tableView.reloadData()
        HUD.hide()
    }
    
    @objc fileprivate func didFailGetVideos (_ notification: Notification) {
        HUD.hide()
        showMessage(title: "Произошла ошибка")
    }
    
}

