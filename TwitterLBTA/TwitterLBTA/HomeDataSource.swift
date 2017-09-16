//
//  HomeDataSource.swift
//  TwitterLBTA
//
//  Created by Tiago Bastos on 18/07/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//


import LBTAComponents
import TRON
import SwiftyJSON

extension Collection where Iterator.Element == JSON {
    
    func decode<T: JSONDecodable>() throws -> [T] {
        return try map({try T(json: $0)})
    }
    
}

class HomeDatasource: Datasource, JSONDecodable {
    
    let users: [User]
    let tweets: [Tweet]
    
    required init(json: JSON) throws {
        
        guard let users_array = json["users"].array,
            let tweetsJsonArray = json["tweets"].array else {
            throw NSError(domain: "tiagoalexbastos.tutoriais", code: 1, userInfo: [NSLocalizedDescriptionKey: "not valid json"])
        }
        
        
//        self.users = users_array.map{User(json: $0)}
//        
//        self.tweets = tweetsJsonArray.map{Tweet(json: $0)}
//        
//        
        
        self.users = try users_array.decode()
        self.tweets = try tweetsJsonArray.decode()
    }
    
        
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
}
