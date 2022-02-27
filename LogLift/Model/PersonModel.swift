//
//  PersonModel.swift
//  LogLift
//
//  Created by Гамлет on 17.02.22.
//

import Foundation

typealias Persons = [Person]

struct Person: Codable, Identifiable {
    var id: UUID
    var name: String
    var login: String
    var password: String
    var workouts: [Workout]
    var personImageData = Data()
}

extension Person {
    static var example: Person {
        Person(id: UUID(), name: "User doesn't exist", login: "nate", password: "1234", workouts: [.exampleWorkout, .exampleWorkout])
    }
}

extension Persons: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Persons.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

