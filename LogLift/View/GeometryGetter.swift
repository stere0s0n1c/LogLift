//
//  GeometryGetter.swift
//  LogLift
//
//  Created by Гамлет on 26.02.22.
//

import SwiftUI

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }
                
                return AnyView(Color.clear)
            }
        }
    }
}

struct GeometryGetter_Previews: PreviewProvider {
    static var previews: some View {
        GeometryGetter(rect: .constant(.zero))
    }
}
