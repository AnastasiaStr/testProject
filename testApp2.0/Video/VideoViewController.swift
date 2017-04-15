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
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()

    
    lazy var videoSlider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor(red: 0.98, green: 0.15, blue: 0.3, alpha: 1)
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "slider"), for: .normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)

        return slider
    }()
    
    func handleSliderChange () {
        
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })

        }
    }
    
    lazy var pausePlayButton : UIButton = {
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
        setupGradientLayer()
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
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 8).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        

    }
    
    var player: AVPlayer?
    
    func setupPlayerView () {
        let urlString = "https://d1wst0behutosd.cloudfront.net/videos/14908695/48221655.mp4?Expires=1492281609&Signature=A3b0FejDMEHiK01J2uPjK0kupt~CTmxW~3~DFw4myzEkEqqRO3BvCBvL9OZrqQKjPPgd9YbdAAKMklTgZFLKRI-oBF4NEY43bYF42H-ftJA4EPLwXO-ZEyGbp-e102w0NiUkF6wujCXLeVbMW7r-axs5FkhHP8-TmvfVB990nu51b7l2PZhJ2EICy0hCFMx-9JsR3Ob-a-CAVBNawIAHDyQlEuEGeeqZUZXccx68lTOwoBnlZ4ZNEU3aJ62hLpcqBwFPrPR77a0lFRdrti8fs3vcI2QOR5nmi~uq2d4nLA8tlFNjfQlwBph5X2PNtuaMiza4W6Jj~vbBBQViY9zKWA__&Key-Pair-Id=APKAJJ6WELAPEP47UKWQ"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.addPeriodicTimeObserver(forInterval: <#T##CMTime#>, queue: <#T##DispatchQueue?#>, using: <#T##(CMTime) -> Void#>)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLenghtLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    private func setupGradientLayer () {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
        
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
    

