//
//  WorkoutSetModel.swift
//  LogLift
//
//  Created by Гамлет on 5.02.22.
//

import Foundation

typealias Kg = Double

struct WorkoutSet: Identifiable, Codable {
    
    let id: UUID
    let weight: Kg
    let reps: Int
    var description: String? = nil
    
    init(id: UUID = UUID(), weight: Kg, reps: Int) {
        self.id = id
        self.weight = weight
        self.reps = reps
    }
    
}

extension WorkoutSet {
    
    static var example: WorkoutSet {
        WorkoutSet(weight: Kg.random(in: 0...100), reps: Int.random(in: 0...10))
    }
    
    var  cleanWeightStr: String {
        weight.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", weight) : String(format: "%.01f", weight)
    }
    
    var setRowTitle: String {
        "\(cleanWeightStr) x \(reps)"
    }
}
