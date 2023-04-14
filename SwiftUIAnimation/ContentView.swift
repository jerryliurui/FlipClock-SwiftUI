//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    @State var moneyCount: Int = 123
    var body: some View {
        VStack(spacing: 30) {
            //AnimationShowView()
//            Spacer()
//            Text("SwiftUI 翻页钟 by JerryLiu")
//                .foregroundColor(.white)
//                .font(.title2)
//
            ClockView()
            
//                ClockView(lastTime: .constant(6), nextTime: .constant(7))
//                    .frame(height: 120)
            //LearnSwiftUIPath()
            
            //contentCardView()
            
//                Button("随机一个数字") {
//                    moneyCount = .random(in: 200...1300)
//                }
//
//                MoneyNumber(font: .system(size: 55), weight: .bold, number: $moneyCount)
        }
        .background(.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
