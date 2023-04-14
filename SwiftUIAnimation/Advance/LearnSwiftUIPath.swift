///
//  LearnSwiftUIPath.swift
//  SwiftUIAnimation
//
//  Tell SwiftUI how to animation my custom shape
//  Shape,animatableData,Animatable,Path
//  一个三角形
//  绘制一个多边形，弧度 Radians 和 度 degress cos 和 sin 三角函数
//  animation 绘制多边形
//
//  Created by JerryLiu on 2022/11/19.
//

import SwiftUI

struct threeOrFourLineShape: Shape {
    //多边形有几个边
    var sides: Int
    
    func path(in rect: CGRect) -> Path {
        var resultPath = Path()
        
        if sides == 3 {
            //三角形
            resultPath.move(to: CGPoint(x: rect.midX, y: rect.minY))
            resultPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            resultPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            resultPath.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        } else {
            //四边形
            resultPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
            resultPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            resultPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            resultPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            resultPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
        
        return resultPath
    }
}

struct animationThreeOrFourLineShape: Shape {
    //多边形有几个边
    var sides: Double
    
    var animatableData: Double {
        get { sides }
        set { sides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        print("绘制\(sides)边形")
        
        //是否是3.X 这样的
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        
        var resultPath = Path()
        
        //斜边
        let h = Double(min(rect.width, rect.height) / 2.0)
        
        //矩形的中心点
        let center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        
        for i in 0..<Int(sides) + extra {
            print("正在寻找第\(i)个点")
            
            //角度
            let degree = Double(i) * (360/Double(sides))
            let radian = degree * Double.pi / 180
            
            let pt = CGPoint(x: center.x + cos(radian) * h, y: center.y + sin(radian) * h)
            
            if i == 0 {
                resultPath.move(to: pt)
            } else {
                resultPath.addLine(to: pt)
            }
        }
        
        resultPath.closeSubpath()
        
        return resultPath
    }
}

//AnimatablePair for two property
//But if we want three or four property what we can do?
//think
//CGRect
//CGSize
//find swiftui document to find ”: Animatable“
struct animationThreeOrFourLineShapeWithColor: Shape {
    //多边形有几个边
    var sides: Double
    var scale: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatableData(sides, scale) }
        set {
            sides = newValue.first
            scale = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        print("绘制\(sides)边形")
        
        //是否是3.X 这样的
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        
        var resultPath = Path()
        //斜边
        let h = Double(min(rect.width, rect.height) / 2.0) * scale
        
        //矩形的中心点
        let center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        
        for i in 0..<Int(sides) + extra {
            print("正在寻找第\(i)个点")
            
            //角度
            let degree = Double(i) * (360/Double(sides))
            let radian = degree * Double.pi / 180
            
            let pt = CGPoint(x: center.x + cos(radian) * h, y: center.y + sin(radian) * h)
            
            if i == 0 {
                resultPath.move(to: pt)
            } else {
                resultPath.addLine(to: pt)
            }
        }
        
        resultPath.closeSubpath()
        
        return resultPath
    }
}

struct LearnSwiftUIPath: View {
    @State var play : Bool = false
    
    @State var scale: Double = 1.0
    @State var side: Int = 3
    @State var chooseSideArray: Array = [3,4,7,10,20]
    
    var body: some View {
        VStack (alignment: .center, spacing: 50.0) {
        
            threeOrFourLineShape(sides: side)
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200, alignment: .center)
                .animation(.default, value: play)
            
            animationThreeOrFourLineShapeWithColor(sides: Double(side), scale: scale)
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200, alignment: .center)
                .animation(.easeInOut(duration: 4), value: side)
            
            HStack {
                Button("3") {
                    self.scale = 1.0
                    self.side = 3
                }
                
                Button("4") {
                    self.scale = 0.9
                    self.side = 4
                }
                
                Button("10") {
                    self.scale = 0.6
                    self.side = 10
                }
                
                Button("20") {
                    self.scale = 0.5
                    self.side = 20
                }
            }
            
            Picker("多边形", selection: $side) {
                ForEach(0..<chooseSideArray.count, id: \.self) { index in
                    Text("\(chooseSideArray[index])")
                        .tag(chooseSideArray[index])
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct LearnSwiftUIPath_Previews: PreviewProvider {
    static var previews: some View {
        LearnSwiftUIPath()
    }
}
