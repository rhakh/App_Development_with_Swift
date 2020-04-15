//
//  Order.swift
//  Restaurant
//
//  Created by Роман Гах on 23.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
