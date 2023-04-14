//
//  MatchViewAnimation.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct MatchViewAnimation: View {
    @State var show: Bool = false
    //定义一个namespace
    @Namespace var namespace
    
    var body: some View {
        VStack {
            //if else 会使得这两个View拥有不同的Id
            //在WWDC 揭开SwiftUI神秘面纱 Session当中有提到
            if show {
                
                VStack {
                    Spacer()
                    
                    //通过ID来让SwiftUI找到不同的View
                    Text("Los Angles Lakers logo")
                        .matchedGeometryEffect(id: "name", in: namespace)
                    Image("Los Angles Lakers logo")
                        .matchedGeometryEffect(id: "logo", in: namespace)
                }
                
            } else {
                VStack {
                    Image("Los Angles Lakers logo")
                        .matchedGeometryEffect(id: "logo", in: namespace)
                    Text("Los Angles Lakers logo")
                        .matchedGeometryEffect(id: "name", in: namespace)
                    Spacer()
                }
            }
        }.onTapGesture {
            withAnimation (.easeIn(duration: 2)) {
                show.toggle()
            }
        }
    }
}

struct MatchViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        MatchViewAnimation()
    }
}
