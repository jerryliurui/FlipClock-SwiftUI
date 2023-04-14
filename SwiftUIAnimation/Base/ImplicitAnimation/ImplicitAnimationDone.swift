//
//  ExplicitAnimationDone.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct ImplicitAnimationDone: View {
    @State var animating: Bool = false
    
    var body: some View {
        Image("spain_large")
            //add an Animation to a view
            //他是一个modifier
            //他会影响所有关联的元素动画
            // value 被 SwiftUI watching
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red)
                    .scaleEffect(animating ? 3 : 1)
                    .opacity(animating ? 1 : 0.1)
                    .animation(.easeIn(duration: 1).repeatForever(), value: animating)
            )
            .onTapGesture {
                animating.toggle()
            }
            .onAppear {
                animating.toggle()
            }
    }
}

//隐式动画不仅可以作用于View 也可以作用于binding data 也就是别的View组件来通过影响value 来设置动画
//binding value
struct ImplicitBindingDataDone : View {
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        Image("spain_large")
            .scaleEffect(scale)
        
        Stepper("缩放", value: $scale.animation(
            .easeIn(duration: 2)
        ), in: 1...10)
        .padding(.horizontal,30)
    }
}

struct ImplicitAnimationDone_Previews: PreviewProvider {
    static var previews: some View {
        VStack (spacing: 100) {
            ImplicitAnimationDone()
            
            ImplicitBindingDataDone()
        }
    }
}
