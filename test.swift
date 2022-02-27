//
//  test.swift
//  LogLift
//
//  Created by Гамлет on 15.02.22.
//

import SwiftUI

struct test: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
        @State private var name = Array<String>.init(repeating: "", count: 3)

        var body: some View {

            VStack {
                Group {
                    Text("Some filler text").font(.largeTitle)
                    Text("Some filler text").font(.largeTitle)
                }

                TextField("enter text #1", text: $name[0])
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("enter text #2", text: $name[1])
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("enter text #3", text: $name[2])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))

            }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
        }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
