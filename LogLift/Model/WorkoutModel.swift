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
        let set = sets.reduce(WorkoutSet(weight: 0, reps: 0), { partialResult, workoutSet in
            workoutSet.weight > partialResult.weight ? workoutSet : partialResult
        })
        return (set.weight, set.reps)
    }
}

extension Workouts {
    func getBestTypeWorkout(for type: ExerciseType) -> Workout? {
        var workout = self.reduce(Workout(id: UUID(), date: Date.now, type: type, sets: [WorkoutSet(weight: 0, reps: 0)]), { partialResult, workout in
            guard workout.type == type else { return partialResult }
            return workout.maxWeightOfWorkout > partialResult.maxWeightOfWorkout ? workout : partialResult
        })
        workout.sets = workout.sets.filter({ $0.weight == workout.maxWeightOfWorkout.weight})
        return workout
    }
}
