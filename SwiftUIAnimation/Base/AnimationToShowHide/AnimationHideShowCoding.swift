//
//  AnimationHideShowCoding.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationHideShowCoding: View {
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            Button("XX") {
                show.toggle()
            }
            
            if show {
                Rectangle()
                    .frame(width: 200, height: 200, alignment: .center)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct AnimationHideShowCoding_Previews: PreviewProvider {
    static var previews: some View {
        AnimationHideShowCoding()
    }
}
