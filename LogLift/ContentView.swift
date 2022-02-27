//
//  ContentView.swift
//  LogLift
//
//  Created by Гамлет on 5.02.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var personService = PersonViewModel()
    
    var body: some View {
        Home()
            .environmentObject(personService)
            .onAppear {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                AppDelegate.orientationLock = .portrait
            }.onDisappear {
                AppDelegate.orientationLock = .all
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
