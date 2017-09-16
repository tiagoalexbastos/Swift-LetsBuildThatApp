//
//  VideoLauncher.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 20/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
    func showVideoPlayer() {
        print("Showing video player")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9/16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completed) in

                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
