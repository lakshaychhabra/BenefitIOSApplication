//
//  PlayVideosViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 21/07/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import AVKit

class PlayVideosViewController: UIViewController {
    
    
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer!
    let controller = AVPlayerViewController()
    var videosURL = [AVPlayerItem]()
    
    @IBOutlet var videoView: UIView!
    @IBOutlet var playerButtonView: UIView!
    



    override func viewDidLoad() {
        super.viewDidLoad()

        
        playerButtonView.isHidden = true
        
        DispatchQueue.main.async {
            
            if self.player == nil {
               self.player = AVQueuePlayer()
            }
            
            self.player = AVQueuePlayer(items: self.videosURL)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer)
            print("Playing Videos on screen")
            self.player.play()
            
        }
        
    }
    

    @IBAction func tapButton(_ sender: Any) {
        
        player.pause()
        playerButtonView.isHidden = false
    }
    
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        
        player.pause()
        dismiss(animated: true)
        
        
    }
    
    
//    @objc func showVideoPlayer(notification: Notification){
//
//
//    }
    

    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    
}
