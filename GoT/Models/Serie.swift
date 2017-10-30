import UIKit
import SwiftyJSON

final class Serie: NSObject {
    var title: String?, year: String?, released: String?, genre: String?, writers: String?, country: String?, imdbRating: String?, totalSeasons: String?, seasons: [String:Season]?, imdbID: String?
    var networkRequests: [Any?] = []
    var delegate:NetworkManagerDelegateSerie?
    
    init(title: String?, year: String?, released: String?, genre: String?, writers: String?, country: String?, imdbRating: String?, totalSeasons: String?, seasons: [String:Season]?, imdbID: String?) {
        self.title = title
        self.year = year
        self.released = released
        self.genre = genre
        self.writers = writers
        self.country = country
        self.imdbRating = imdbRating
        self.totalSeasons = totalSeasons
        self.seasons = seasons
        self.imdbID = imdbID
    }
    
    override init(){
        super.init()
        self.seasons = [:]
    }
    
    func getData(imdbID: String!, closure: ()-> Void){
        self.imdbID = imdbID
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
        
        if let n = Int((self.totalSeasons!)){
            for i in 1...n{
                let season = Season(imdbID: self.imdbID, season: "\(i)")
                season.delegate = self
            }
        }
    }
}

extension Serie: NetworkManagerDelegateSeason {
    func didDownloadPost(postArray: Season) {
        self.seasons?[postArray.season!] = postArray
        self.delegate?.didDownloadPost(postArray: self)
    }
}
