//
//  LoginButton.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct LoginButton: View {
    
    var actionHandler: () -> Void
    var body: some View {
        Button {
            actionHandler()
        } label: {
            
            Label("Login", systemImage: "lock")
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .background(LinearGradient(colors: [Color(uiColor: .systemTeal), Color(uiColor: .systemPurple)], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .shadow(radius: 10)
                
        }.padding()
        
    }
    
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton {
            
        }
    }
}
