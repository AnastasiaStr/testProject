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

class VideoPlayerView : UIView {
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let videoLenghtLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let videoSlider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor(red: 0.98, green: 0.15, blue: 0.3, alpha: 1)
        slider.setThumbImage(UIImage(named: "slider"), for: .normal)

        return slider
    }()
    
    let pausePlayButton : UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    var isPlaying = false
    
    func handlePause () {
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        
        
        isPlaying = !isPlaying
    
        
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        backgroundColor = .black
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLenghtLabel)
        videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        

    }
    
    var player: AVPlayer?
    
    func setupPlayerView () {
        let urlString = "https://d1wst0behutosd.cloudfront.net/videos/14912931/48242352.mp4?Expires=1492273966&Signature=dplf2ubbWD2n3qkAFg~IhRP6yahOuk7keO4arIx~080qiCoD7tyFP1DZarvkeuURH-f4WnoNMpILJ~9aokLaTbQLJwQUfx2tIDskqcHz3pBkS8hL935j-meqhB1B391RH5r-UkiVKM~FRs2IQUdr3t4yYRIBdQWWB-QNcGMgSNgBaCTk670I-WjQfWgBD3Y1ip9naG6Daq6tV7L5qU4-qHtGPyxmU8jIbDOE0814Fxk-~r6o-rJJMdApWRqxDH3mDttMGW8dIfG9PGuzduYT7RE8jZ-Xq81hEdRJdlk--EOk5JRB0Fqn8dokrnqw-PkP7hOrpgrRdwHuj5DrZLUsaA__&Key-Pair-Id=APKAJJ6WELAPEP47UKWQ"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
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
    

