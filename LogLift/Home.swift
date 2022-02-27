//
//  Home.swift
//  LogLift
//
//  Created by Гамлет on 17.02.22.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var personService: PersonViewModel
        
    @StateObject private var currentvScreenViewModel = CurrentScreenViewModel()
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(colors: [Color(uiColor: .red), Color(uiColor: .systemIndigo)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            switch currentvScreenViewModel.state {
            case .onboarding:
                Onboarding(stepper: $currentvScreenViewModel.state)
            case .login:
                Login(stepper: $currentvScreenViewModel.state, currentPerson: $personService.currentPerson)
            case .register:
                Registration(stepper: $currentvScreenViewModel.state, currentPerson: $personService.currentPerson)
            case .authorized(let id):
                Main(stepper: $currentvScreenViewModel.state, currentPerson: $personService.users.first(where: {
                    $0.id.description == id
                })  ?? .constant(.example)
                )
            }
        }
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

