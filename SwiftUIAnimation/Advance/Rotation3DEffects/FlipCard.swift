//
//  FlipCard.swift
//  SwiftUIAnimation
//
//  3DRotate Card
//
//  Created by JerryLiu on 2022/11/21.
//

import SwiftUI

struct contentCardView : View {
    @State var fliped: Bool = false
    @State var front : Bool = true
    
    var body: some View {
        ZStack {
            card(title: "golden-state-warriors", content: "ITA COURSE", icon: "golden-state-warriors",colorArray: [Color("WarriorsHome"), Color("WarriorsYellow")])
                .opacity(front ? 1 : 0)
            card(title: "Los Angles Lakers logo", content: "ITA COURSE", icon: "Los Angles Lakers logo", colorArray: [Color("LakerGuest"), Color("LakerHome")])
                .opacity(front ? 0 : 1)
        }
        .modifier(FlipEffect(angle: front ? 180 : 0, flipped: $fliped))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                front.toggle()
            }
        }
    }
}

struct card: View {
    var title: String = ""
    var content: String = ""
    var icon: String = ""
    
    var colorArray: [Color] = []
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(colors: colorArray, startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 300, height: 200)
            .shadow(radius: 10)
            .overlay {
                VStack {
                    Image(icon)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text(title)
                        .font(.title2)
                        .foregroundColor(.white)
                    
                }
            }
    }
}

struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    var angle: Double
    
    @Binding var flipped: Bool
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle <= 270
        }
        
        print(angle)
        
        let newAngle = flipped ? 180-angle : angle
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1 / max(size.width, size.height)
        
        let angleRadians = CGFloat(Angle(degrees: newAngle).radians)
        
        transform3d = CATransform3DRotate(transform3d, angleRadians, 1, 0, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2, -size.height/2, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2, y: size.height/2))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}


struct FlipCard_Previews: PreviewProvider {
    static var previews: some View {
        contentCardView()
    }
}
