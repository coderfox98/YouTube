//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Rish on 30/09/18.
//  Copyright © 2018 Rish. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let controlsContainerView : UIView = {
        let ccv = UIView()
        ccv.backgroundColor = .clear
        return ccv
    }()

    let pausePlayButton : UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying : Bool = false
    
    @objc func handlePause() {
        if isPlaying == false {
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
            player?.pause()
        }
        else {
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            player?.play()
        }
        
        isPlaying = !isPlaying
    }
    
    let activityIndicatorView : UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView()
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    let videoLengthLabel : UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoScrubber : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.maximumTrackTintColor = .white
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoScrubber.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completed) in
                // add func
            })
            
        }
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVideoPlayer()
        setupGradientLayer()
        backgroundColor = .black
        controlsContainerView.frame = self.frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        controlsContainerView.addSubview(videoScrubber)
        videoScrubber.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0).isActive = true
        videoScrubber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        videoScrubber.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 0).isActive = true
        videoScrubber.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
       
    }
    
    var player : AVPlayer?
    
    private func setupVideoPlayer() {
        let urlString = "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8"
        //        "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            // track Player Progress
            
            let interval = CMTime(value: 1, timescale: 3)
 
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy:60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // Move the slider Thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoScrubber.value = Float(seconds / durationSeconds)
                }
                
            })
            }
        
    }
    
    private func setupGradientLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7 , 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // player is ready
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            pausePlayButton.isHidden = false
            if let duration = player?.currentItem?.duration {
               let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
               let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

class VideoLauncher : NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            keyWindow.addSubview(view)
            let height = keyWindow.frame.width * (9 / 16)
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)

            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
}
