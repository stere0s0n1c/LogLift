//
//  RegisterButton.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct RegisterButton: View {
    
    var actionHandler: () -> Void
    
    var body: some View {
        Button {
            actionHandler()
        } label: {
            Text("Register")
        }
        .font(.title2)
        .padding()
        .buttonStyle(.plain)
        .foregroundColor(Color(uiColor: .systemYellow))
    }
}

struct RegisterButton_Previews: PreviewProvider {
    static var previews: some View {
        RegisterButton {
            
        }
    }
}
