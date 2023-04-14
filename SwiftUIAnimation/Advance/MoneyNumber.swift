//
//  MoneyNumber.swift
//  SwiftUIAnimation
//
//  股票、货币翻滚View
//
//  Created by JerryLiu on 2022/11/17.
//

import SwiftUI

struct MoneyNumber: View {
    var font: Font = .largeTitle
    var weight: Font.Weight = .regular
    @Binding var number: Int
    
    @State var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("8")
                    .font(font)
                    .fontWeight(weight)
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let size = proxy.size
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text("\(number)")
                                        .font(font)
                                        .fontWeight(weight)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y:-CGFloat(animationRange[index]) * size.height)
                        }
                        .allowsHitTesting(false)
                    }
                    .clipped()
            }
        }
        .onAppear {
            animationRange = Array(repeating: 0, count: "\(number)".count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                updateNumber()
            }
        }
        .onChange(of: number) { newValue in
            let diff = "\(number)".count - animationRange.count
            if diff > 0 {
                //需要添加
                for _ in 0 ..< diff {
                    withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.append(0)
                    }
                }
                
            } else {
                //需要删除
                for _ in 0 ..< -diff {
                    let _ = withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.removeLast()
                    }
                }
            }
            
            updateNumber()
        }
    }
    
    func updateNumber(){
        let stringValue = "\(number)"
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            
            var fractor = Double(index) * 0.15
            fractor = (fractor > 0.5) ? 0.5 : fractor
            
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1 + fractor, blendDuration: 1 + fractor)) {
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

struct MoneyNumber_Previews: PreviewProvider {
    
    static var previews: some View {
        MoneyNumber(number: .constant(000))
    }
}
