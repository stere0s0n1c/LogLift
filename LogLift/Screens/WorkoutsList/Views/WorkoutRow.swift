//
//  WorkoutRow.swift
//  LogLift
//
//  Created by Гамлет on 5.02.22.
//

import SwiftUI

struct WorkoutRow: View {
    
    let workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.date, format: .dateTime.day().month().year()).font(.headline)
                HStack {
                    Text("Sets: \(workout.sets.count) |")
                    Text("Max: \( String(format: "%.1f", workout.maxWeightOfWorkout.weight)) kg")
                }.foregroundColor(.gray)
            }
            Spacer()
            Text(workout.type.rawValue).font(.headline)
        }.padding(10)
            .foregroundColor(.indigo)
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(workout: .exampleWorkout)
    }
}
