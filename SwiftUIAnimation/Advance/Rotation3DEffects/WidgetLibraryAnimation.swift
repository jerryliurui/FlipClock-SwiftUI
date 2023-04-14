//
//  WidgetLibraryAnimation.swift
//  SwiftUIAnimation
//
//  模仿widget library 中的3d螺旋的一个动画
//
//  Created by JerryLiu on 2022/11/21.
//

import SwiftUI

struct WidgetLibraryAnimation: View {
    
    @State var animating: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Image("Los Angles Lakers logo")
                    .frame(width: 200, height: 200, alignment: .center)
                    .shadow(color: .black.opacity(0.6), radius: 20,x: 40)
                    .rotation3DEffect(Angle(degrees: animating ? -10: 10), axis: (x: 0, y: 1, z: 0))
                    .animation(.easeInOut(duration: 15).repeatForever(), value: animating)
                    .rotation3DEffect(Angle(degrees: animating ? -10:10), axis: (x: 0, y: 0, z: 1))
                    .animation(.easeInOut(duration: 15).repeatForever().delay(1), value: animating)
                    .onAppear{
                        animating.toggle()
                }
                
                Color.red
                    .frame(width: 2)
                
                Color.red
                    .frame(height: 2)
            }
        }
        .frame(width: 300, height: .infinity, alignment: .center)
        .background(.cyan)
    }
}

struct WidgetLibraryAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WidgetLibraryAnimation()
    }
}
