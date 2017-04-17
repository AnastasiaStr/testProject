//
//  VideoViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 15.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerView : UIView {
    
    var function : ()->() = {}
    
    lazy var closeButton : UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleClose), for: .touchDragExit)
        return button
    }()
    
    func handleClose (sender : UIButton) {
        player?.replaceCurrentItem(with: nil)
        function()
    }
    
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
        label.textAlignment = .left
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    
    var isPlaying = true
    
    func handlePause () {
        
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
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
    }
    
    func start (url: String, frame: CGRect, function: @escaping ()->()) {
        self.function = function
        setupPlayerView(url: url)
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
        pausePlayButton.widthAnchor.constraint(equalTo: controlsContainerView.widthAnchor).isActive = true
        pausePlayButton.heightAnchor.constraint(equalTo: controlsContainerView.heightAnchor).isActive = true
      
        controlsContainerView.addSubview(closeButton)
        closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        controlsContainerView.addSubview(videoLenghtLabel)
        videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    var player: AVPlayer?
    
    var playerLayer = AVPlayerLayer()
    
    var videoUrl: String?
    
    func setupPlayerView (url: String) {
        let urlString = url
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)

                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds/durationSeconds)
                    
                }
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            
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

class VideoViewController: UIView {

    var fullVideoURL: String?
    var likes = 0
    var title: String?
    var desc: String?
    
    
    lazy var likeButton : UIButton = {
        let button = UIButton(type: .system)
        var image = UIImage()
        image = UIImage(named: "no_like")!
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    

    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
   let likesCountLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    let descText : UITextView = {
        let label = UITextView()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.isEditable = false
        return label
    }()
    
    func deleteScreen () {
        if let keyWindow = UIApplication.shared.keyWindow {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)

        }, completion: { (completedAnimation) in
            self.view.removeFromSuperview()
            self.removeFromSuperview()
        })
  
        }
    }
    
    var view = UIView()
    
    func showVideo() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 60, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView.init(frame: videoPlayerFrame)
            videoPlayerView.start(url: fullVideoURL!, frame: videoPlayerFrame, function: deleteScreen)
            view.addSubview(videoPlayerView)
            
            titleLabel.text = title
            view.addSubview(titleLabel)
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
            titleLabel.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 13).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true

            titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

            likesCountLabel.text = String(likes)
            view.addSubview(likesCountLabel)
            likesCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
            likesCountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            likesCountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            likesCountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            descText.text = desc
            view.addSubview(descText)
            descText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
            descText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
            descText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
            descText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
            
            view.addSubview(likeButton)
            likeButton.rightAnchor.constraint(equalTo: likesCountLabel.leftAnchor, constant: -8).isActive = true
            likeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
            likeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            likeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true

            
            keyWindow.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
}
