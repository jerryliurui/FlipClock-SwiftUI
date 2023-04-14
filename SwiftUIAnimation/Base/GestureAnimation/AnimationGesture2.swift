//
//  AnimationGesture2.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/18.
//

import SwiftUI

struct AnimationGesture2: View {
    let worldCupCountry = Array("🇪🇸🇧🇷🇫🇷🇳🇱🏴󠁧󠁢󠁥󠁮󠁧󠁿🇯🇵🇰🇷🇶🇦🇩🇪🇦🇷")
    @State private var changeColor : Bool = false
    @State private var dragPosition = CGSize.zero
    
    var body: some View {
        HStack (spacing:0) {
            ForEach(0..<worldCupCountry.count, id: \.self) { index in
                Text(String(worldCupCountry[index]))
                    .padding(1)
                    .font(.title)
                    .background(changeColor ? Color("LakerHome") : Color("LakerGuest"))
                    .offset(dragPosition)
                    .animation(
                        .default.delay(Double(index)/20),
                        value: dragPosition)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragPosition = $0.translation }
                .onEnded { _ in
                    dragPosition = CGSize.zero
                    changeColor.toggle()
                }
        )
    }
}

struct AnimationGesture2_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGesture2()
    }
}
