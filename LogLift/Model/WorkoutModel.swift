//
//  ExerciseModel.swift
//  LogLift
//
//  Created by Гамлет on 5.02.22.
//

import Foundation

typealias Workouts = [Workout]

enum ExerciseType: String, CaseIterable, Codable {
    case pullUp = "Pull ups"
    case dip = "Dips"
    
    var description: String { self.rawValue }
}

struct Workout: Identifiable, Codable {
    let id: UUID
    let date:  Date
    var type: ExerciseType
    var sets: [WorkoutSet]
}

extension Workout {
    
    static var exampleWorkout: Workout {
        Workout(id: UUID(), date: Date.now, type: .dip, sets:
                    [
                        WorkoutSet(weight: 0, reps: 20),
                        WorkoutSet(weight: 15.3213123000, reps: 10),
                        WorkoutSet(weight: 35, reps: 6),
                        WorkoutSet(weight: 45, reps: 3),
                        WorkoutSet(weight: 55, reps: 2),
                        WorkoutSet(weight: 75.3213213, reps: 1),
                        WorkoutSet(weight: 30, reps: 7)
                    ])
    }
    
    var maxWeightOfWorkout: (weight: Kg, reps: Int) {
        guard let set = sets.sorted(by: { $0.weight > $1.weight }).first else { return (0, 0) }
        return (set.weight, set.reps)
    }
}

extension Workouts {
    func getBestTypeWorkout(for type: ExerciseType) -> Workout? {
        guard let workout = self.filter({ $0.type == type}).sorted(by: { $0.maxWeightOfWorkout.weight > $1.maxWeightOfWorkout.weight}).first else { return nil }
        var workoutPrep = workout
        let bestSet = workoutPrep.sets.filter({ $0.weight == workoutPrep.maxWeightOfWorkout.weight})
        workoutPrep.sets = bestSet
        return workoutPrep
    }
}
