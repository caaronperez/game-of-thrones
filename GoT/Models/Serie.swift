//
//  Serie.swift
//  GoT
//
//  Created by MCS Devices on 10/26/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

final class Serie: NSObject {
    var title: String?, year: String?, released: String?, genre: String?, writers: String?, country: String?, imdbRating: String?, totalSeasons: String?, seasons: [String:Season]?, imdbID: String?
    var networkRequests: [Any?] = []
    
    init(imdbID: String!){
        self.imdbID = imdbID
        super.init()
        let myNetworkManager = NetworkManager()
        networkRequests.append(myNetworkManager)
        myNetworkManager.delegate = self
        myNetworkManager.downloadAPIPost(imdbID: imdbID)
    }
}

extension Serie: NetworkManagerDelegate {
   
    func didDownloadPost(postArray: [String: Any]) {
        self.title = postArray[oMDBAPI.title] as? String
        self.year = postArray[oMDBAPI.year] as? String
        self.released = postArray[oMDBAPI.released] as? String
        self.genre = postArray[oMDBAPI.genre] as? String
        self.writers = postArray[oMDBAPI.writer] as? String
        self.country = postArray[oMDBAPI.country] as? String
        self.imdbRating = postArray[oMDBAPI.imdbRating] as? String
        self.totalSeasons = postArray[oMDBAPI.totalSeasons] as? String
        if let n = Int(totalSeasons!){
            for i in 1...n{
                let season = Season(imdbID: self.imdbID, season: "\(i)")
                self.seasons?["\(i)"] = season
            }
        }
    }
}
