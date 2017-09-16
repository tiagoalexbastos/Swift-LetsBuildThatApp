//
//  Service.swift
//  TwitterLBTA
//
//  Created by Tiago Bastos on 25/07/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    static let sharedInstance = Service()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?) -> ()) {
        let request: APIRequest<HomeDatasource, JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: {
            (homeDataSource) in
            
            completion(homeDataSource, nil)
            
            
        }
            , failure: {
                (error) in
                
                let err = error as? APIError<JSONError>
                err?.response?.statusCode
                
                completion(nil, error)
                print("error")
        })
        
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print ("JSON ERROR")
        }
    }
}
