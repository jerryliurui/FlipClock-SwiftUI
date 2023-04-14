//
//  ExplicitAnimationDone.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct ExplicitAnimationDone: View {
    @State var degree : Double = 0.0
    var body: some View {
        VStack {
            Image("spain_large")
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
            
            Button("Click Me") {
                withAnimation {
                    degree += 180
                }
                
            }
        }
    }
}

struct ExplicitAnimationDone_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimationDone()
    }
}
