//
//  WorkoutViewModel.swift
//  LogLift
//
//  Created by Гамлет on 6.02.22.
//

import Foundation
import SwiftUI
import Combine

class WorkoutsListViewModel: ObservableObject {
    
    @Published var isShowingWorkoutreversedList = false
    
    @Published var workouts: [Workout] = [
        Workout(id: UUID(), date: Date.now, type: .dip, sets:
                    [
                        WorkoutSet.example,
                        WorkoutSet.example,
                        WorkoutSet.example,
                    ]
               ),
        Workout(id: UUID(), date: Date.now, type: .pullUp, sets:
                    [
                        WorkoutSet.example,
                        WorkoutSet.example,
                        WorkoutSet.example,
                    ]
               ),
    ]
    
    @Published var workoutsReversed : [Workout] = []
    
    private var bag = Set<AnyCancellable>()
    
    func createNewWorkout(newCurrentWorkout: Binding<Workout>) {
        let newWorkout: Workout = Workout(id: UUID(), date: Date.now, type: ExerciseType.allCases.randomElement() ?? .dip, sets: [])
        workouts.append(newWorkout)
        newCurrentWorkout.wrappedValue = newWorkout
    }
    
    func deleteWorkout(at indexSet: IndexSet) {
        let workoutIds = Set(indexSet.map { workoutsReversed[$0].id })
        workouts.removeAll { workoutIds.contains($0.id) }
    }
    
    func deleteRep(at workout: Workout, in indexSet: IndexSet) {
        guard let currentWorkout = workouts.enumerated().first(where: { currentWorkout in
            workout.id == currentWorkout.element.id
        }) else { return }
        let workoutIndex = currentWorkout.offset
        workouts[workoutIndex].sets.remove(atOffsets: indexSet)
    }
    
    init() {
        configureWorkoutsList()
    }
    
    private func configureWorkoutsList() {
        Publishers
            .CombineLatest($workouts, $isShowingWorkoutreversedList)
            .map({ workouts, isShowingWorkoutreversedList in
                return workouts.reversed()
            })
            .assign(to: \.workoutsReversed, on: self)
            .store(in: &bag)
    }
}
