//
//  NetworkManagerDelegate.swift
//  TableViewNetworking
//
//  Created by Adolfo on 8/10/17.
//  Copyright © 2017 AdolfoGarza. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkManagerDelegate: class {
    func didDownloadPost(postArray: [String: Any])
}


