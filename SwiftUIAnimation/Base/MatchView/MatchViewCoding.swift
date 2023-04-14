//
//  MatchViewCoding.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct MatchViewCoding: View {
    
    @State var show: Bool = false
    @Namespace var namespace
    
    
    var body: some View {
        VStack {
            
            if show {
                Spacer()
                
                Image("Los Angles Lakers logo")
                    .matchedGeometryEffect(id: "logo", in: namespace)
                
                Text("Los Angles Lakers logo")
                    .font(.largeTitle)
                    .matchedGeometryEffect(id: "name", in: namespace)
                
            } else {
                
                Text("Los Angles Lakers logo")
                    .font(.largeTitle)
                    .matchedGeometryEffect(id: "name", in: namespace)
                
                Image("Los Angles Lakers logo")
                    .matchedGeometryEffect(id: "logo", in: namespace)
                Spacer()
            }
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 2)) {
                show.toggle()
            }
        }
    }
}

struct MatchViewCoding_Previews: PreviewProvider {
    static var previews: some View {
        MatchViewCoding()
    }
}
