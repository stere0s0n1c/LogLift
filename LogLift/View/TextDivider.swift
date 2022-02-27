//
//  TextDivider.swift
//  LogLift
//
//  Created by Гамлет on 19.02.22.
//

import SwiftUI

struct TextDivider: View {
    
    let text: String
    
    var body: some View {
        HStack {
            VStack {
                Divider()
            }
            Text(text)
                .font(.title3)
                .foregroundColor(.white)
            VStack {
                Divider().foregroundColor(.white)
            }
        }
    }
    
}

struct TextDivider_Previews: PreviewProvider {
    static var previews: some View {
        TextDivider(text: "OR")
    }
}
