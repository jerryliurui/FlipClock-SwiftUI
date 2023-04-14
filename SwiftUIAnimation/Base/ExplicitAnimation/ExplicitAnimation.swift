//
//  ExplicitAnimation.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct ExplicitAnimation: View {
    @State var degree: Double = 0.0
    
    var body: some View {
        VStack {
            Image("spain_large")
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 0, z: 1))
            
            Button("翻转") {
                withAnimation {
                    degree += 180
                }
                
            }
        }
    }
}

struct ExplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimation()
    }
}
