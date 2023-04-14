//
//  AnimationShowView.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationShowView: View {
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            Button("点我") {
                withAnimation {
                    show.toggle()
                }
            }
            
            if show {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .offset(x:100)))
            }
        }
    }
}

struct AnimationShowView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationShowView()
    }
}
