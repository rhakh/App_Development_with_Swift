//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Роман Гах on 10.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        
        return components?.url
    }
    
    func withHTTPS() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.scheme = "https"
        
        return components?.url
    }
}
