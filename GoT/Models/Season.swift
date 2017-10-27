//
//  Season.swift
//  GoT
//
//  Created by MCS Devices on 10/26/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

final class Season: NSObject {

    var season: String?, episodes: [[String:Any]]?, title: String?
    var networkRequests: [Any?] = []
    
    init(imdbID: String!, season: String){
        super.init()
        let myNetworkManager = NetworkManager()
        networkRequests.append(myNetworkManager)
        myNetworkManager.delegate = self
        if let imdb = imdbID {
            myNetworkManager.downloadAPIPost(imdbID: "\(imdb)\(oMDBAPI.seasonEndpoint)\(season)")
        }
    }
    
    override init(){
        
    }
     
}

extension Season: NetworkManagerDelegate {
    func didDownloadPost(postArray: [String: Any]) {
        self.season = postArray[oMDBAPI.season] as? String
        self.title = postArray[oMDBAPI.title] as? String
        if let jsonEpisodes = postArray[oMDBAPI.episodes] as? NSArray {
            for dictionary in jsonEpisodes{
                episodes?.append(dictionary as! [String: Any])
            }
        }
    }
}
