//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Роман Гах on 10.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

class PhotoInfoController {
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key": "DEMO_KEY"
        ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, url) in
            let jsonDecoder = JSONDecoder()
                
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("No data was returned")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
