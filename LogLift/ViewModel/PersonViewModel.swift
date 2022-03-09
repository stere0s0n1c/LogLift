//
//  PersonViewModel.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import Foundation

import SwiftUI

typealias PersonIdStr = String

final class PersonViewModel: ObservableObject {
    
    @AppStorage("authorizedPersonId") var authPersonId: PersonIdStr = ""
    @AppStorage("isUserAuthorized") var isUserAuthorized: Bool = false
    @AppStorage("users") var users = Persons()
    @Published var currentPerson: Person = Person(id: UUID(), name: "publisher", login: "stronger", password: "1234", workouts: [])
    
}

