//
//  Rotation3DVideo.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/12/2.
//

import SwiftUI

struct Rotation3DVideo: View {
    @State var degree = 45.0
    
    var body: some View {
        VStack(spacing:80) {
            HStack {
                ZStack {
                    Rotation3DTestView(degree: $degree, axisX: 1, axisY: 0, axisZ: 0)
                    Color.red
                        .frame(height: 2)
                }
                Text("change X")
            }
            
            
            HStack {
                ZStack {
                    Rotation3DTestView(degree: $degree, axisX: 0, axisY: 1, axisZ: 0)
                    
                    Color.red
                        .frame(width: 2)
                }
                Text("change Y")
            }
            
            HStack {
                ZStack {
                    Rotation3DTestView(degree: $degree, axisX: 0, axisY: 0, axisZ: 1)
                    Color.red
                        .frame(width: 10, height: 10)
                }
                Text("change Z")
            }
            
            HStack {
                Text("角度:\(degree)")
                Button("复原") {
                    degree = 0.0
                }
            }
            
            Slider(value: $degree, in: -180...180, step: 1)
        }
        
    }
}

struct Rotation3DVideo_Previews: PreviewProvider {
    static var previews: some View {
        Rotation3DVideo()
    }
}

struct Rotation3DPreviewView: View {
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
