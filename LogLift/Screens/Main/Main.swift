//
//  Main.swift
//  LogLift
//
//  Created by Гамлет on 7.02.22.
//

import SwiftUI

struct Main: View {
    
    @Binding var stepper: CurrentScreenState
    @Binding var currentPerson: Person
    
    private enum TabMain {
        case workouts
        case profile
    }
    
    var body: some View {
        switch stepper {
        case .authorized:
            tabMain()
        case .onboarding, .register, .login:
            EmptyView()
        }
    }
    
    private func tabMain() -> some View {
        TabView {
            WorkoutsList(currentDetailWorkout: .exampleWorkout, currentPerson: $currentPerson)
                .tag(TabMain.workouts)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            Profile(stepper: $stepper, currentPerson: $currentPerson)
                .tag(TabMain.profile)
                .tabItem {
                    Image(systemName: "person.crop.square.fill")
                }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(stepper: .constant(.authorized("")), currentPerson: .constant(.example))
    }
}
