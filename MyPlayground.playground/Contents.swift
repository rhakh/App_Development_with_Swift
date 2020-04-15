import UIKit
import Foundation

#if false
//class Employee: Equatable {
//    static func == (lhs: Employee, rhs: Employee) -> Bool {
//        return lhs.name == rhs.name &&
//            lhs.age == rhs.age &&
//            lhs.title == rhs.title
//    }
//
//    let name: String
//    let age: Int
//    let title: String
//
//    init(name: String, age: Int, title: String) {
//        self.name = name
//        self.age = age
//        self.title = title
//    }
//}
#else
struct Employee: Equatable, Comparable, Codable {
    let name: String
    let age: Int
    let title: String
    
    static func <(lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name < rhs.name
    }
}
#endif

func comparison(lhs: Employee, rhs: Employee) {
    if lhs == rhs {
        print("\(lhs.name) = \(rhs.name)")
    }
    else {
        print("\(lhs.name) != \(rhs.name)")
    }
}

let jsonEncoder = JSONEncoder()

var first = Employee(name: "Omar", age: 28, title: "CEO")
var second = Employee(name: "Sting", age: 23, title: "KO")
var copy = Employee(name: "Omar", age: 28, title: "CEO")

comparison(lhs: first, rhs: second)
comparison(lhs: first, rhs: copy)

if let jsonData = try? jsonEncoder.encode(first),
    let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
    print(jsonData)
}




print("End")
