//
//  AnimationGroup.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationGroup: View {
    @State var animating: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 200)
                //modifier order
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(.red)
            
            Button("点我") {
                animating.toggle()
            }
        }
        .frame(width: 300, height: 300)
        .scaleEffect(animating ? 0.5 : 1)
        .animation(nil, value: animating)
        .background(animating ? .blue : .red)
        .animation(.default.repeatForever(), value: animating)
        .clipShape(RoundedRectangle(cornerRadius: animating ? 100 : 0))
        .animation(.default, value: animating)
        
        //切割 state change 为各个小块
    }
}

struct AnimationGroup_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGroup()
    }
}
