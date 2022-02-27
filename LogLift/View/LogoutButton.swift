//
//  LogoutButton.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct LogoutButton: View {
    
    var actionHandler: () -> Void
    
    var body: some View {
        
        Button {
            actionHandler()
        } label: {
            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
        }
        .padding()
        .foregroundColor(.red)
    
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton {
            
        }
    }
}
