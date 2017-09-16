//
//  SubscriptionCell.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 20/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        APIService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
