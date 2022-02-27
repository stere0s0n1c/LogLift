//
//  CircleImage.swift
//  LogLift
//
//  Created by Гамлет on 23.02.22.
//

import SwiftUI

struct CircleImage: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.mint, lineWidth: 5)
            }
            .shadow(radius: 9)
    }
    
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: UIImage())
    }
}

