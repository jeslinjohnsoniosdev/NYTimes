//
//  Network.swift
//  NYTimes
//
//  Created by Jeslin Johnson on 01/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import Foundation
import Keys

var keys: NYTimesKeys? = NYTimesKeys.init()

func networkRequest(with path: String, queryParams: [String : String]?, bodyParams: [String : Any]?, method: HttpMethod) -> URLRequest? {
    guard let apiKey = keys?.nYAPIKey else {
        return nil
    }
    let urlString = BASEURL + path + ".json?api-key=\(apiKey)"
    guard var url = URL(string: urlString) else {
        return nil
    }
    if let params = queryParams {
        for param in params {
            url.appendQueryItem(name: param.key, value: param.value)
        }
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    return request
}
