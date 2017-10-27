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
    weak var delegate2:NetworkManagerDelegate?
  
    func downloadAPIPost(imdbID: String){
        let urlString = URL(string: "\(oMDBAPI.endPoint)\(imdbID)")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print(error as Any)
                } else {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                            DispatchQueue.main.async {
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
    }
}

