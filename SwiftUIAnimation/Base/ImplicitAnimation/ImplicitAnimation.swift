//
//  ExplicitAnimation.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct ImplicitAnimation: View {
    //定义一个State 变量来追踪是否动画
    @State var animating: Bool = false
    var body: some View {
        Image("spain_large")
        //add an animation to a view
        //他是一个modifier
        //他会影响所有关联的元素动画
        //value 会被SwiftUI watching
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red)
                    .scaleEffect(animating ? 3 : 1)
                    .opacity(animating ? 1 : 0.3)
                    .animation(.easeIn(duration: 1).repeatForever(), value: animating)
            )
            .onTapGesture {
                animating.toggle()
            }
    }
}

struct ImplicitAnimation1: View {
    //定义一个State 变量来记录尺寸
    // binding value animation
    @State var scale: CGFloat = 1.0
    var body: some View {
        VStack {
            Image("spain_large")
                .scaleEffect(scale)
            Stepper("缩放大小", value: $scale.animation(
                .easeOut(duration: 2)
            ), in: 1...10)
        }
        
    }
}


struct ImplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimation1()
    }
}
