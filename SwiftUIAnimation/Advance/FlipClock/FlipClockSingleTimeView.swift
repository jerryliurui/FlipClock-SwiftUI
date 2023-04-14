//
//  FlipClockSingleTimeView.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/23.
//

import SwiftUI

struct FlipClockSingleTimeView: View {
    
    //上一个时间数字 比如5
    @Binding var lastTimeNumber: Int
    
    //下一个时间数字 比如6
    @Binding var nextTimeNumber: Int
    
    //正在动画
    @Binding var animating: Bool
    
    //是否翻转到垂直屏幕
    @State var cardHasFlipVertical: Bool = false
    
    //是否开始动画
    @State var beginAnimation: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                //state1
                //动画阶段0
                //C下半部分减掉 B全部减掉 A全部留下来
                
                //state2
                //动画阶段0-0.5 翻转90°的过程中
                //C下半部分减掉 B下半部分减掉 上半部分露出 A全部留下来
                
                //state3
                //动画部分0.5-1 翻转90°-180°的过程中
                //C的上半部分减掉 B下半部分减掉 上半部分露出 A全部留下来
                
                //let _ = Self._printChanges()
                //let _ = print("FlipClockSingleTimeView : \(lastTimeNumber) \(nextTimeNumber)")
                
                //现在的时间 A
                SingleTimeStaticNumberView(timeNumber: lastTimeNumber)
                
                //下一个时间 B
                SingleTimeStaticNumberView(timeNumber: nextTimeNumber)
                    .opacity(beginAnimation ? 1 : 0)
                    .mask {
                        unoverlayView()
                    }
                
                //动画的时间 C
                SingleTimeStaticNumberView(timeNumber: cardHasFlipVertical ? nextTimeNumber : lastTimeNumber)
                    .mask {
                        overlayView(fliped: $cardHasFlipVertical)
                    }
                    .modifier(FlipSingleTimeEffect(angle: animating ? 180 : 360, cardHasFlipVertical: $cardHasFlipVertical, begin: $beginAnimation, shouldAnimation: $animating,lastNumber: $lastTimeNumber,nextNumber: $nextTimeNumber))
                    .animation(animating ? Animation.easeInOut(duration: 0.8) : nil, value: animating)
                
                Color.black.opacity(0.5)
                    .frame(width:100, height: 4)
            }
        }
    }
}

struct overlayView : View {
    @Binding var fliped: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if fliped {
                    Spacer()
                }
                
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: geometry.size.width, height: geometry.size.height/2)
                
                if !fliped {
                    Spacer()
                }
            }
        }
    }
}

struct unoverlayView : View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: geometry.size.width, height: geometry.size.height/2)
                Spacer()
            }
        }
    }
}

struct SingleTimeStaticNumberView: View {
    var timeNumber: Int
    
    var body: some View {
        ZStack {
            Text("\(timeNumber)")
                // HelveticaNeue-CondensedBold 寻找一个等宽的字体
                .font(Font.custom("HelveticaNeue-CondensedBold", size: 150))
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .frame(width: 100)
        .background(.black)
        .cornerRadius(10)
    }
}

struct HalfViewFlip_Previews: PreviewProvider {
    static var previews: some View {
        FlipClockSingleTimeView(lastTimeNumber: .constant(4), nextTimeNumber: .constant(5), animating: .constant(false))
    }
}

struct FlipSingleTimeEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    var angle: Double
    @Binding var cardHasFlipVertical: Bool
    @Binding var begin: Bool
    @Binding var shouldAnimation: Bool
    
    @Binding var lastNumber: Int
    @Binding var nextNumber: Int
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        if angle < 360 && angle > 180 {
            DispatchQueue.main.async {
                begin = true
            }
        }
        
        if angle == 180 {
            DispatchQueue.main.async {
                shouldAnimation = false
                lastNumber = nextNumber
                begin = false
            }
        }
        
        DispatchQueue.main.async {
            cardHasFlipVertical = angle >= 180 && angle <= 270
        }
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = CGFloat.leastNormalMagnitude
        
        //print(size)
        
        let angleRadians = CGFloat(Angle(degrees: angle).radians)
        
        //print(angle)
        
        transform3d = CATransform3DRotate(transform3d, angleRadians, 1, 0, 0)
        
        if cardHasFlipVertical {
            transform3d = CATransform3DRotate(transform3d, -.pi, 0, 0, 1)
            transform3d = CATransform3DRotate(transform3d, -.pi, 0, 1, 0)
        }
        
        transform3d = CATransform3DTranslate(transform3d, -size.width/2, -size.height/2, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2, y: size.height/2))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
