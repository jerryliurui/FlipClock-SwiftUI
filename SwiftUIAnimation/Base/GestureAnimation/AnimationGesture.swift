//
//  AnimationGesture.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/18.
//

import SwiftUI

struct AnimationGesture: View {
    //记录拖拽位置
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 200, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation } //$0 代表的是block中的第一个参数
                    .onEnded { _ in dragAmount = CGSize.zero }
            )
            .animation(.spring(), value: dragAmount)
    }
}

struct AnimationGestureWithoutOnChange: View {
    //记录拖拽位置
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 200, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation } //$0 代表的是block中的第一个参数
                    .onEnded { _ in
                            withAnimation {
                                dragAmount = CGSize.zero
                            }
                    }
            )
    }
}

struct AnimationGesture_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestureWithoutOnChange()
    }
}
