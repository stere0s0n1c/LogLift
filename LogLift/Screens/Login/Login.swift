//
//  Login.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject var personService: PersonViewModel
    
    @Binding var stepper: CurrentScreenState
    @Binding var currentPerson: Person

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {

            loginView()

            if viewModel.isLoading {
                loadingView()
                    .transition(.opacity)
            }

        }

    }

    private func loadingView() -> some View {
        ZStack {
            Color
                .black
                .opacity(0.75)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.indigo)

        }
    }

    private func loginView() -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2038285525, green: 0.678160598, blue: 0.9036881057, alpha: 1)), Color(#colorLiteral(red: 0.5713630915, green: 0.3590525389, blue: 0.8180366755, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            VStack {

                VStack(alignment: .center) {

                    Text("Personal LogLift Account")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)


                    TextField("Login", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.some(.username))
                        .padding(.bottom, 20)

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.some(.password))

                    LoginButton {
                        viewModel.login(stepper: $stepper, persons: $personService.users, currentPerson: $currentPerson)
                    }
                    .disabled(!viewModel.isLoginEnabled)

                    TextDivider(text: "OR")

                    RegisterButton {
                        stepper = .register
                    }

                }
                .padding()
                .background(LinearGradient(colors: [ Color(#colorLiteral(red: 0.2038285525, green: 0.678160598, blue: 0.9036881057, alpha: 1)), Color(#colorLiteral(red: 0.3695652187, green: 0.5138014555, blue: 0.7935982347, alpha: 1))], startPoint: .top, endPoint: .bottom))
                .opacity(0.8)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .shadow(radius: 8)

                Text(viewModel.hint)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .frame(minHeight: 30)

            }
        }
        

    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(stepper: .constant(.login), currentPerson: .constant(.example))
    }
}
