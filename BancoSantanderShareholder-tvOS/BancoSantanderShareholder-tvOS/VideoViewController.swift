//
//  VideoViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 15/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit
import AVFoundation
import HCYoutubeParser


class VideoViewController: UIViewController {
   
    var movie : Movie?
    
    var avPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let theMovieId = movie?.videoId {
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "pausePlayTapped:")
            tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)];
            self.view.addGestureRecognizer(tapRecognizer)
        
            let youTubeString : String = "https://www.youtube.com/watch?v=" + theMovieId
            let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
            let urlString : String = videos["medium"] as! String
            let asset = AVAsset(URL: NSURL(string: urlString)!)
            
            let avPlayerItem = AVPlayerItem(asset:asset)
            avPlayer = AVPlayer(playerItem: avPlayerItem)
            let avPlayerLayer  = AVPlayerLayer(player: avPlayer)
            avPlayerLayer.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height);
            self.view.layer.addSublayer(avPlayerLayer)
            avPlayer.play()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pausePlayTapped(gesture: UITapGestureRecognizer){
     
        if avPlayer.rate == 1.0 {
        
            avPlayer.pause()
            
        } else {
            
            avPlayer.play()
        }
        
    }
    

}
