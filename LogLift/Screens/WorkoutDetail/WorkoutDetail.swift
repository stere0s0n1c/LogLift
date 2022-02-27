//
//  WorkoutDetail.swift
//  LogLift
//
//  Created by Гамлет on 8.02.22.
//

import SwiftUI

struct WorkoutDetail: View {
    
    @StateObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    @StateObject private var setVewModel = SetViewModel()
    @Binding var workout: Workout
    @State var showNewSetModal = false
    
    var body: some View {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(uiColor: .systemBlue))]
        
        return ZStack {
            VStack {
                ExerciseTypePickerView(title: "Exercise type", exerciseType: $workout.type).pickerStyle(.menu)
                
                NavigationView {
                    List {
                        Section(footer: workout.sets.isEmpty ? Text("") : Text("Sets: \(workout.sets.count)")) {
                            ForEach(workout.sets, id: \.id) { set in
                                Text(set.setRowTitle)
                                
                            }.onDelete(perform: { indexSet in
                                setVewModel.deleteSet(at: indexSet, workout: $workout)
                            })
                        }
                        
                    }.listStyle(.insetGrouped)
                        .navigationTitle(Text(workout.date, format: .dateTime.day().month().year()))
                        .navigationTitle("Workouts")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showNewSetModal.toggle()
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.blue)
                                }.animation( Animation.easeIn(duration: 1), value: showNewSetModal)
                                    .disabled(showNewSetModal)
                            }
                        }
                }
                
            }.padding()
            
            if showNewSetModal {
                Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.8))
                    .edgesIgnoringSafeArea(.all)
            }
            GeometryReader { proxy in
                
                NewSetModal(kGuardian: kGuardian, workout: $workout, showNewSetModal:  $showNewSetModal, proxy:  proxy)
                    .offset(y: showNewSetModal ? 0 : 600)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showNewSetModal)
                    .environmentObject(setVewModel)
                    .onAppear { self.kGuardian.addObserver()
                        print(self.kGuardian.slide)
                    }
                    .onDisappear { self.kGuardian.removeObserver() }
            }
        }
    }
}

struct WorkoutDetail_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetail(workout: .constant(.exampleWorkout))
    }
}
