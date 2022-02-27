//
//  LoginViewModel.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//
import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @ObservedObject var personService = PersonViewModel()
    
    @Published var username: String = ""
    
    @Published var password: String = ""
    
    @Published var isLoginEnabled: Bool = false
    
    @Published var isLoading: Bool = false
    
    @Published var hint: String = ""
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        Publishers
            .CombineLatest($username, $password)
            .map({ username, password in
                username.count > 3 && password.count > 3
            })
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &bag)
    }
    
    func login(stepper: Binding<CurrentScreenState>, persons: Binding<Persons>, currentPerson: Binding<Person>) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        withAnimation {
            isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let strongSelf = self else { return }
            withAnimation {
                strongSelf.isLoading = false
            }
            let hasUser = persons.wrappedValue.contains(where: { $0.login == strongSelf.username && $0.password == strongSelf.password })
            
            if hasUser {
                if let existingPerson = persons.wrappedValue.first(where: { $0.login == strongSelf.username && $0.password == strongSelf.password }) {
                    stepper.wrappedValue = .authorized(existingPerson.id.description)
                    currentPerson.wrappedValue =  existingPerson
                    strongSelf.personService.authPersonId = existingPerson.id.description
                    strongSelf.personService.isAuth = true
                }
            } else {
                strongSelf.hint = "User doesn't exist"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    strongSelf.hint = ""
                }
            }
        }
    }
    
}
