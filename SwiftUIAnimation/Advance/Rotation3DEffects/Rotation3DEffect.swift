//
//  Rotation3DEffect.swift
//  SwiftUIAnimation
//
//  Explain how Rotation3DEffect  +/-  -pi~pi
//
//  Created by JerryLiu on 2022/11/22.
//

import SwiftUI

struct Rotation3DEffect: View {
    
    @State var degree = 0.0
    
    var body: some View {
        VStack(spacing:80) {
            HStack {
                Rotation3DTestView(degree: $degree, axisX: 1, axisY: 0, axisZ: 0)
                
                Text("change X")
                    .foregroundColor(.primary)
            }
            
            HStack {
                Rotation3DTestView(degree: $degree, axisX: 0, axisY: 1, axisZ: 0)
                Text("change Y")
                    .foregroundColor(.primary)
            }
            
            HStack {
                Rotation3DTestView(degree: $degree, axisX: 0, axisY: 0, axisZ: 1)
                Text("change Z")
                    .foregroundColor(.primary)
            }
            
            HStack {
                Text("角度:  \(degree)")
                
                Button("复原") {
                    withAnimation {
                        degree = 0.0
                    }
                }
            }
            
            Slider(value: $degree, in: -180...180, step: 1)
        }
    }
}

struct Rotation3DEffect_Previews: PreviewProvider {
    static var previews: some View {
        Rotation3DEffect()
    }
}

struct Rotation3DTestView: View {
    @Binding var degree: Double
    
    @State var axisX: CGFloat
    @State var axisY: CGFloat
    @State var axisZ: CGFloat
    
    var body: some View {
        VStack {
            LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 100, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .rotation3DEffect(Angle(degrees: degree), axis: (x: axisX, y: axisY, z: axisZ))
        }
    }
}

struct TestFlipTimeEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    var angle: Double
    
    @Binding var text: Int
    @Binding var frontViewHasFold: Bool
    
    func effectValue(size: CGSize) -> ProjectionTransform {
    
        DispatchQueue.main.async {
            frontViewHasFold = angle >= -180 && angle <= -90
        }
        
        var transform3d = CATransform3DIdentity
        
        print(size)
        
        let angleRadians = CGFloat(Angle(degrees: angle).radians)
        
        print(angle)
        
        transform3d = CATransform3DRotate(transform3d, angleRadians, 0, 0, 0)
        
        transform3d = CATransform3DMakeRotation(angleRadians, 1, 0, 0)
        
        if frontViewHasFold {
            transform3d = CATransform3DRotate(transform3d, .pi, 0, 0, 1)
            transform3d = CATransform3DRotate(transform3d, .pi, 0, 1, 0)
        }
        
        transform3d.m34 = 1.0 / -500
        
        transform3d = CATransform3DTranslate(transform3d, 0, -40, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: 0, y: size.height))
        
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
