//
//  WorkoutsList.swift
//  LogLift
//
//  Created by Гамлет on 7.02.22.
//

import SwiftUI

struct WorkoutsList: View {
    
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State var isShowingNewDetailWorkout = false
    @State var currentDetailWorkout: Workout
    @Binding var currentPerson: Person
    
    
    
    
    var body: some View {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(uiColor: .systemIndigo))]
        
        return NavigationView {
            
            VStack {
                NavigationLink(destination: WorkoutDetail(workout: $currentPerson.workouts.first(where: { $0.id == currentDetailWorkout.id }) ?? .constant(.exampleWorkout)), isActive: $isShowingNewDetailWorkout) { EmptyView() }
                
                workoutCells()
                
            }
        }
        
    }
    
    private func workoutCells() -> some View {
        List {
            
            ForEach(currentPerson.workouts.reversed(), id: \.id) { workout in
                NavigationLink {
                    WorkoutDetail(workout: $currentPerson.workouts.first(where: { $0.id == workout.id }) ?? .constant(.exampleWorkout))
                } label: {
                    WorkoutRow(workout: workout)
                }
                
            }
            .onDelete(perform: {
                workoutViewModel.deleteWorkout(at: $0, currentPerson: $currentPerson)
            })
            
        }.navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingNewDetailWorkout.toggle()
                        workoutViewModel.addNewWorkout(newCurrentWorkout: $currentDetailWorkout, currentPerson: $currentPerson)
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .foregroundColor(.indigo)
                    }
                }
            }
    }
}

struct WorkoutsList_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsList(currentDetailWorkout: .exampleWorkout, currentPerson: .constant(.example))
    }
}
