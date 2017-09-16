//
//  APIService.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 19/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
    static let sharedInstance = APIService()
    
    private let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchUrlForString(urlString: "\(baseUrl)home.json", completion: completion)
    }
    
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchUrlForString(urlString: "\(baseUrl)trending.json", completion: completion)
        
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchUrlForString(urlString: "\(baseUrl)subscriptions.json", completion: completion)
        
    }
    
    func fetchUrlForString(urlString: String, completion: @escaping ([Video]) -> ()){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]]{
                    
                    DispatchQueue.main.async(execute: {
                        completion(jsonDictionaries.map({
                            return Video(dictionary: $0)
                        }))
                    })
                    
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
}
