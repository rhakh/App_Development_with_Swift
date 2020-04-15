//
//  ToDo.swift
//  ToDoList
//
//  Created by Роман Гах on 12.02.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let DocumentDirectory = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
    ).first!
    
    static let ArchiveURL = DocumentDirectory
                            .appendingPathComponent("todos")
                            .appendingPathExtension("plist")
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")

        return [todo1, todo2, todo3]
    }
    
    static func saveToDos(array todos: [ToDo]) {
        let encode = PropertyListEncoder()
        
        let codedToDos = try? encode.encode(todos)
                        try? codedToDos?.write(to: ArchiveURL,
                                               options: .noFileProtection)
        
    }
}
