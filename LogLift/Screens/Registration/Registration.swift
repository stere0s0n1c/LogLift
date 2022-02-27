//
//  Registration.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct Registration: View {
    
    @EnvironmentObject var personService: PersonViewModel
    
    @Binding var stepper: CurrentScreenState
    @Binding var currentPerson: Person
    
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2038285525, green: 0.678160598, blue: 0.9036881057, alpha: 1)), Color(#colorLiteral(red: 0.5713630915, green: 0.3590525389, blue: 0.8180366755, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                .ignoresSafeArea()
            VStack {
                
                TextField("Login", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 15)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .textFieldStyle(.roundedBorder)

                    .padding(.bottom, 15)
                
                SecureField("Password again", text: $viewModel.passwordAgain)
                    .textFieldStyle(.roundedBorder)
                    .textFieldStyle(.roundedBorder)

                
                HStack {
                    RegisterButton {
                        viewModel.register(stepper: $stepper, persons: $personService.users, currentPerson: $personService.currentPerson)
                    }
                    .padding()
                    .disabled(!viewModel.isValid)
                    
                    Spacer()
                    
                    Button {
                        viewModel.cancel(stepper: $stepper)
                    } label: {
                        Text("Cancel")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .padding()
                }
                
            }
            .padding()
        }
        
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration(stepper: .constant(.register), currentPerson: .constant(.example))
    }
}
