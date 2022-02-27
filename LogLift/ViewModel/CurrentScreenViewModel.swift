//
//  CurrentScreenViewModel.swift
//  LogLift
//
//  Created by Гамлет on 18.02.22.
//

import Foundation
import SwiftUI

enum CurrentScreenState {
    case login
    case register
    case authorized(PersonIdStr)
    case onboarding
}

class CurrentScreenViewModel: ObservableObject {
    
    @Published var state: CurrentScreenState = .onboarding
    @ObservedObject var personService = PersonViewModel()
    
    init() {
        if personService.isAuth {
            self.state = .authorized(personService.authPersonId)
        } else {
            self.state = .onboarding
        }
    }
    
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

