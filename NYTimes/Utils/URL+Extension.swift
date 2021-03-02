//
//  URL+Extension.swift
//  NYTimes
//
//  Created by Chanchal Raj on 02/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import Foundation

extension URL {
    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
