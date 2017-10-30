//
//  Chapter.swift
//  GoT
//
//  Created by MCS Devices on 10/26/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class Chapter: NSObject {
    
    var titleChapter: String?, yearChapter: String?, reated: String?, releasedChapter: String?, seasonChapter: String?, episode: String?, runtime: String?, genreChapter: String?, director: String?, writer: String?, actors: String?, plot: String?, language: String?, country: String?, awards: String?, poster: String?, ratings: [String:String]?, metascore: String?, imdbRating: String?, imdbVotes: String?, imdbID: String?, seriesID: String?, type: String?
    var networkRequests: [Any?] = []
    var delegate:NetworkManagerDelegateChapter?
    
    init(imdbID: String!){
        super.init()
        self.imdbID = imdbID
        let myNetworkManager = NetworkManager()
        networkRequests.append(myNetworkManager)
        myNetworkManager.delegate = self
        myNetworkManager.downloadAPIPost(imdbID: imdbID)
    }
    
}

extension Chapter: NetworkManagerDelegate {
    func didDownloadPost(postArray: [String: Any]) {
        self.titleChapter = postArray[oMDBAPI.chapterTitle] as? String
        self.yearChapter = postArray[oMDBAPI.year] as? String
        self.reated = postArray[oMDBAPI.rated] as? String
        self.releasedChapter = postArray[oMDBAPI.released] as? String
        self.seasonChapter = postArray[oMDBAPI.season] as? String
        self.episode = postArray[oMDBAPI.epidose] as? String
        self.runtime = postArray[oMDBAPI.runtime] as? String
        self.genreChapter = postArray[oMDBAPI.genre] as? String
        self.director = postArray[oMDBAPI.director] as? String
        self.writer = postArray[oMDBAPI.writer] as? String
        self.actors = postArray[oMDBAPI.actors] as? String
        self.plot = postArray[oMDBAPI.plot] as? String
        self.language = postArray[oMDBAPI.language] as? String
        self.country = postArray[oMDBAPI.country] as? String
        self.awards = postArray[oMDBAPI.awards] as? String
        self.poster = postArray[oMDBAPI.poster] as? String
        self.ratings = postArray[oMDBAPI.ratings] as? [String : String]
        self.metascore = postArray[oMDBAPI.metascore] as? String
        self.imdbRating = postArray[oMDBAPI.imdbRating] as? String
        self.imdbVotes = postArray[oMDBAPI.imdbVotes] as? String
        self.imdbID = postArray[oMDBAPI.imdbID] as? String
        self.seriesID = postArray[oMDBAPI.seriesID] as? String
        self.type = postArray[oMDBAPI.type] as? String
        
        self.delegate?.didDownloadPost(postArray: self)
        
    }
    
}

