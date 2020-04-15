//
//  MenuController.swift
//  Restaurant
//
//  Created by Роман Гах on 24.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    static var shared = MenuController()
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    static let serverIP = "192.168.1.2"
    static var baseURLStr: String { return "http://\(serverIP):8090/" }
    let baseURL = URL(string: baseURLStr)!
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(
                name: MenuController.orderUpdateNotification,
                object: nil)
        }
    }
    
    func fetchCategories(completion: @escaping ([String]?) -> Void)
    {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL)
        { (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let categories = jsonDictionary["categories"] as? [String]
            {
                completion(categories)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String,
                        completion: @escaping ([MenuItem]?) -> Void)
    {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data)
            {
                var copyItems: [MenuItem] = []
                
                // TODO: imageURL contain localhost:8090 instead from 192....
                // replate localhost to serverip
                for var menuItem in menuItems.items {
                    let urlStr = menuItem.imageURL.absoluteString.replacingOccurrences(
                                                of: "localhost",
                                                with: MenuController.serverIP)
                    menuItem.imageURL = URL(string: urlStr)!
                    copyItems.append(menuItem)
                }
                
                completion(copyItems)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void)
    {
        let my_url = URL(string: "http://192.168.1.2:8090/images/4.png")
        let isImage = try? Data(contentsOf: my_url!)
        print("IsImage = \(isImage)")
        
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int],
                     completion: @escaping (Int?) -> Void)
    {
        var orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data)
            {
                completion(preparationTime.prepTime)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
