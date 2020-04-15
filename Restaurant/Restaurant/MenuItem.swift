//
//  MenuItem.swift
//  Restaurant
//
//  Created by Роман Гах on 22.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}

struct Categories: Codable {
    var categories: [String]
}

struct PreparationTime: Codable {
    var prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
