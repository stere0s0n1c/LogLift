//
//  NewSetModal.swift
//  LogLift
//
//  Created by Гамлет on 11.02.22.
//

import SwiftUI
import Combine



struct NewSetModal: View {
    
    @ObservedObject var kGuardian: KeyboardGuardian
    
    @EnvironmentObject private var setViewModel: SetViewModel
    
    @Binding var workout: Workout
    @Binding var showNewSetModal: Bool
    
    @State private var newSetReps = 0
    @State private var newSetWeightStr = "0"
    @State var proxy: GeometryProxy
    @State private var startLocation = CGPoint(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 2)
    @State private var endLocation = CGPoint(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 2)
    @State private var closeTranslationX = UIScreen.screenHeight / 3.3
    
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var initLocation: CGPoint? = nil
    
    @FocusState private var wieghtIsFocused: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(alignment: .top) {
                    
                    weightView()
                    
                    Spacer()
                    
                    Divider()
                    
                    Spacer()
                    
                    repsView()
                    
                    closeView()
                }
                .padding()
                
                AddNewSetButton(proxy: proxy, workout: workout) {
                    setViewModel.addSet(to: $workout, weight: $newSetWeightStr, reps: $newSetReps)
                    wieghtIsFocused = false
                    showNewSetModal = false
                }
            }
            .padding(.top, 100)
            .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenHeight / 2.3, alignment: .center)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: kGuardian.keyboardIsHidden ? 0 : -(kGuardian.keyboardRect.size.height - kGuardian.slide))
            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.3), value: kGuardian.keyboardIsHidden)
            
        }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            .position(endLocation)
            .gesture(simpleDrag.simultaneously(with: fingerDrag))
            .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0), value: endLocation)
        
    }
    
    private var simpleDrag: some Gesture {
        
        DragGesture(coordinateSpace: .local)
            .onChanged { value in
                if kGuardian.keyboardIsHidden {
                    if value.translation.height > -100 && value.translation.height < closeTranslationX {
                        var newLocation = initLocation ?? endLocation // 3
                        newLocation.y += value.translation.height
                        self.endLocation = newLocation
                    } else {
                        return
                    }
                }
            }
            .onEnded({ value in
                if kGuardian.keyboardIsHidden {
                    if value.translation.height > closeTranslationX {
                        showNewSetModal = false
                        self.endLocation = self.startLocation
                    } else {
                        self.endLocation = self.startLocation
                    }
                }
            })
            .updating($initLocation) { (value, initLocation, transaction) in
                initLocation = initLocation ?? endLocation // 2
            }
    }
    
    private var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    private func repsView() -> some View {
        HStack {
            Text("Reps")
                .bold()
                .font(.system(size: 24))
            
            Picker("", selection: $newSetReps) {
                ForEach(0...60, id: \.description) { value in
                    Text("\(value)")
                        .tag(value)
                        .foregroundColor(.red)
                        .font(.headline)
                }
            }.pickerStyle(.menu)
                .frame(width: 50, height: 50, alignment: .center)
            
        }.foregroundColor(.black)
    }
    
    private func weightView() -> some View {
        HStack(spacing: 10) {
            
            Text("Weight, Kg")
                .bold()
            TextField("", text: $newSetWeightStr)
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                .foregroundColor(.cyan)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
                .onReceive(Just(newSetWeightStr)) { newValue in
                    let filtered = newValue.filter {$0.isNumber || $0 == "."}
                    if filtered != newValue {
                        self.newSetWeightStr = filtered
                    }
                }
                .submitLabel(.continue)
                .focused($wieghtIsFocused)
            
        }.foregroundColor(.black)
        
    }
    
    private func closeView() -> some View {
        Image(systemName: "xmark")
            .frame(width: 30, height: 30)
            .offset(y: -100)
            .foregroundColor(.black)
            .onTapGesture {
                self.showNewSetModal = false
                wieghtIsFocused = false
            }
        
    }
}


//struct NewSetModal_Previews: PreviewProvider {
//    static var previews: some View {
//        NewSetModal(workout: .constant(.exampleWorkout), showNewSetModal: .constant(true))
//    }
//}
