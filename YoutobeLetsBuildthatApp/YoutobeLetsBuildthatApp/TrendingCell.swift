//
//  TrendingCell.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 20/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        APIService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
