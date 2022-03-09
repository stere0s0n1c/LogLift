//
//  Profile.swift
//  LogLift
//
//  Created by Гамлет on 7.02.22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject private var personService: PersonViewModel
    
    @Binding var stepper: CurrentScreenState
    @Binding var currentPerson: Person
    
    @State private var offsetY: CGFloat = 0
    @State private var isShowPhotoLibrary = false
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack {
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [.mint, .blue,.purple], startPoint: .top, endPoint: .bottom))
                        .ignoresSafeArea()

                    VStack {
                        CircleImage(image: ImagePicker.getCorrectPhoto(data: currentPerson.personImageData))
                            .frame(width: proxy.size.height / 3, height: proxy.size.height / 3, alignment: .center)
                            .onTapGesture {
                                isShowPhotoLibrary = true
                            }
                        personInfo()
                    }
                    
                }
                
            }
            
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, imageData: $currentPerson.personImageData)
        }
    }
    
    private func personInfo() -> some View {
        VStack {
            Text(currentPerson.name)
                .foregroundColor(.indigo)
                .font(.title)
                .padding()
            VStack(alignment: .center) {
                Text("BEST RESULTS")
                    .font(.title2)
                    .padding(.bottom, 20)
                HStack {
                    
                    bestSetView(for: .pullUp)
                    
                    Spacer()
                    
                    bestSetView(for: .dip)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
                
                Divider()
                
                LogoutButton {
                    stepper = .onboarding
                    personService.isUserAuthorized = false
                }
                
            }
            .padding()
        }
    }
    
    private func bestSetView(for type: ExerciseType) -> some View {
        VStack {
            Text("\(type.description):")
                .font(.title2)
            
            Text(currentPerson.workouts.getBestTypeWorkout(for: type)?.sets.first?.setRowTitle ?? "-")
                .font(.title2)
                .foregroundColor(.yellow)
            
            Text(currentPerson.workouts.getBestTypeWorkout(for: type)?.date ?? .now, format: .dateTime.day().month().year())
                .font(.caption)
        }
        .padding(30)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.purple, lineWidth: 1)
        }
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(stepper: .constant(.authorized("")), currentPerson: .constant(.example))
            .previewInterfaceOrientation(.portrait)
    }
}
