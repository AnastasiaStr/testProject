//
//  VideoViewController.swift
//  testApp2.0
//
//  Created by Alexander Kravchenko on 15.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import AVKit

class VideoPlayerView : UIView {
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundColor = .black
        

    }
    
    func setupPlayerView () {
        let urlString = "https://d1wst0behutosd.cloudfront.net/videos/14919399/48276825.mp4?Expires=1492266645&Signature=lFnv4v4y7mGYEGtpPpY88O918M~tTGo4SnKepNY5587v951pHkhjSW0zD6ImIIK~K65QfFuvE0MARQpT5U9OiKezlu7yxnct7QiMxL1nUpnWYfrerTOEKVVEXsx6h7Tf-evfT3zoyE5~ZI5v0JrhbJgmaa36bunQvqM-g-eKnyMpS~9A3KyZIJl6e5CBpW~2aWrin8HqM7dhvb~LT0qNWk9TSrH6vae1W5urrDXmAuvgrlod55PEQcvftaiaZZb9X9XA~OL-PN0fo1WBOF7hX4LvAioZc4V7lyIn6Xk3u0Y5q5wWqkF6hncj2ixpnDq9FarnKlNI5SKU94ASmrSKdg__&Key-Pair-Id=APKAJJ6WELAPEP47UKWQ"
        
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
            
            player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class VideoViewController: NSObject {

    var fullVideoURL: String?
    
    func showVideo() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            print ("azaza")
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 60, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView.init(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
    
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    
        
        
       /* let videoURL = NSURL(string: fullVideoURL!)
       
        
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }*/
    }
    
}
    

