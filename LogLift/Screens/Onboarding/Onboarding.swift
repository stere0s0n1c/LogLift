//
//  Onboarding.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct Onboarding: View {
    
    @Binding var stepper: CurrentScreenState

    var body: some View {
        VStack {

            LoginButton {
                stepper = .login
            }

            TextDivider(text: "OR")

            RegisterButton {
                stepper = .register
            }

        }
        .padding()
    }}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(stepper: .constant(.onboarding))
    }
}
