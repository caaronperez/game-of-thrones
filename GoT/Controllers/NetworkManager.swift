//
//  NetworkManager.swift
//  TableViewNetworking
//
//  Created by Adolfo on 8/10/17.
//  Copyright © 2017 AdolfoGarza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkManager {
    
    weak var delegate:NetworkManagerDelegate?
  
    func downloadAPIPost(imdbID: String){
        let urlString = URL(string: "\(oMDBAPI.endPoint)\(imdbID)")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print(error as Any)
                } else {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                            DispatchQueue.main.sync {
                                self?.delegate?.didDownloadPost(postArray: jsonArray)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
        
        
        /*Alamofire.request("https://swapi.co/api/people/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
        }*/
    }
}

