//
//  AnimationGestureCoding1.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/25.
//

import SwiftUI

struct AnimationGestureCoding1: View {
    //记录拖拽的位置
    
    @State var dragCenter = CGSize.zero
    var body: some View {
        LinearGradient(colors: [Color("LakerGuest"), Color("LakerHome")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 200, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(dragCenter)
            .gesture(
                DragGesture()
                    .onChanged {
                        //拖拽时回调
                        dragCenter = $0.translation
                        //$0 代表的是block中第一个参数
                    }
                    .onEnded { _ in
                        //结束时回调
                        withAnimation {
                            dragCenter = CGSize.zero
                            //复原
                            
                        }
                    }
            )
        //开始的时候不希望有，结束的时候希望有~
            
    }
}

struct AnimationGestureCoding1_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestureCoding1()
    }
}
