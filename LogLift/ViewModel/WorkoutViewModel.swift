//
//  WorkoutViewModel.swift
//  LogLift
//
//  Created by Гамлет on 21.02.22.
//

import Foundation
import SwiftUI

final class WorkoutViewModel: ObservableObject {
    
    @ObservedObject private var personViewModel = PersonViewModel()
    
    func addNewWorkout(newCurrentWorkout: Binding<Workout>, currentPerson: Binding<Person>) {
        guard let existingPerson = personViewModel.users.first(where: {
            $0.id == currentPerson.id
        }) else { return }
        let newWorkout: Workout = Workout(id: UUID(), date: Date.now, type: existingPerson.workouts.last?.type == .dip ? .pullUp : .dip, sets: [])
        currentPerson.workouts.wrappedValue.append(newWorkout)
        newCurrentWorkout.wrappedValue = newWorkout
    }
    
    func deleteWorkout(at indexSet: IndexSet, currentPerson: Binding<Person>) {
        currentPerson.workouts.wrappedValue.remove(atOffsets: indexSet)
    }
    
}
