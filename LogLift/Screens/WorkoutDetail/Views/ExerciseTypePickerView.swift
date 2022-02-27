//
//  ExerciseTypePickerView.swift
//  LogLift
//
//  Created by Гамлет on 8.02.22.
//

import SwiftUI

struct ExerciseTypePickerView: View {
    
    var title: String
    @Binding var exerciseType: ExerciseType
    
    var body: some View {
        Picker(title, selection: $exerciseType) {
            ForEach(ExerciseType.allCases, id: \.description) { value in
                Text("\(value.rawValue)")
                    .tag(value)
            }
        }
    }
}

struct ExerciseTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTypePickerView(title: "Exercise type", exerciseType: .constant(.pullUp)).pickerStyle(.menu)
    }
}
