//
//  AnimationOrderCoding.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationOrderCoding: View {
    @State var animating: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 200)
                //回忆modifier order
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .background(.red)
            
            Button("点我") {
                animating.toggle()
            }
        }
        .frame(width: 300, height: 300)
        //animation cut code
        .scaleEffect(animating ? 0.5 : 1)
        .animation(nil, value: animating)
        .background(animating ? .blue : .red)
        .animation(.easeIn(duration: 2), value: animating)
        //切割 state change 为每一个小块
    }
}

struct AnimationOrderCoding_Previews: PreviewProvider {
    static var previews: some View {
        AnimationOrderCoding()
    }
}
