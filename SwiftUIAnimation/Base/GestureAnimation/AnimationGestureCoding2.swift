//
//  AnimationGestureCoding2.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationGestureCoding2: View {
    let worldCupCountry = Array("🇪🇸🇧🇷🇫🇷🇳🇱🏴󠁧󠁢󠁥󠁮󠁧󠁿🇯🇵🇰🇷🇶🇦🇩🇪🇦🇷")
    
    var body: some View {
        HStack (spacing:0) {
            ForEach(0..<worldCupCountry.count, id: \.self) { index in
                Text(String(worldCupCountry[index]))
                    .padding(1)
                    .font(.title)
            }
        }
    }
}

struct AnimationGestureCoding2_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestureCoding2()
    }
}
