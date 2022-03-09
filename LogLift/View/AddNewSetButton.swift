//
//  AddNewSetButton.swift
//  LogLift
//
//  Created by Гамлет on 21.02.22.
//

import SwiftUI

struct AddNewSetButton: View {
    
    let proxy: GeometryProxy
    let workout: Workout
    var actionHandler: () -> Void
    
    var body: some View {
        
        Button(action: {
            actionHandler()
        }) {
            Text("Add to \(workout.type.description)")
                .foregroundColor(.white)
                .frame(width: proxy.size.width / 1.2, height: 44)
                .background(.blue)
                .cornerRadius(20)
                .padding()
            
        }
    }
}

