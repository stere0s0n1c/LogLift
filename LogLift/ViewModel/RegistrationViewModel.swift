//
//  RegistrationViewModel.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI
import Combine


final class RegistrationViewModel: ObservableObject {
    
    @ObservedObject var personService = PersonViewModel()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    
    @Published var isValid: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        Publishers
            .CombineLatest3($username, $password, $passwordAgain)
            .map({ username, password, passwordAgain in
                username.count > 3 && password.count > 3 && password == passwordAgain
            })
            .assign(to: \.isValid, on: self)
            .store(in: &bag)
    }
    
    func register(stepper: Binding<CurrentScreenState>, persons: Binding<Persons>, currentPerson: Binding<Person>) {
        let newPerson = Person(id: UUID(), name: username, login: username, password: password, workouts: [])
        persons.wrappedValue.append(newPerson)
        currentPerson.wrappedValue = newPerson
        stepper.wrappedValue = .authorized(newPerson.id.description)
        personService.authPersonId = newPerson.id.description
        personService.isAuth = true
    }
    
    func cancel(stepper: Binding<CurrentScreenState>) {
        stepper.wrappedValue = .onboarding
    }
    
}
