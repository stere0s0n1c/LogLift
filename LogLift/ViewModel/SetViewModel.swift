//
//  SetViewModel.swift
//  LogLift
//
//  Created by Гамлет on 21.02.22.
//

import Foundation
import SwiftUI

final class SetViewModel: ObservableObject {
    
    func addSet(to workout: Binding<Workout>, weight: Binding<String>, reps: Binding<Int>) {
        guard let weightKg = Kg(weight.wrappedValue) else { return }
        if weight.wrappedValue == "0" && reps.wrappedValue == 0 {
            return
        }
        workout.sets.wrappedValue.append(WorkoutSet(id: UUID(), weight: weightKg, reps: reps.wrappedValue))
        reps.wrappedValue = 0
        weight.wrappedValue = ""
    }
    
    func deleteSet(at indexSet: IndexSet, workout: Binding<Workout>) {
        workout.sets.wrappedValue.remove(atOffsets: indexSet)
    }
}
