//
//  FlipClock.swift
//  SwiftUIAnimation
//
//  翻页时钟 in SwiftUI
//
//  Created by JerryLiu on 2022/11/18.
//

import SwiftUI

struct FlipClock_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ClockView()
        }
    }
}

struct ClockView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var timerToAnimation = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @ObservedObject var hourTimeUnit: TimeUnit = TimeUnit(time:0, unitType: .FlipClockTimeLocationTypeHour)

    @ObservedObject var minuteTimeUnit: TimeUnit = TimeUnit(time: 0, unitType: .FlipClockTimeLocationTypeMinute)

    @ObservedObject var secondTimeUnit: TimeUnit = TimeUnit(time:0, unitType: .FlipClockTimeLocationTypeSecond)
    
    //测试用五个属性
    @State var lastTime: Int = 0
    @State var nextTime: Int = 1
    @State var needAnimation: Bool = false
    
    //是否处在动画中
    @State var firstLabelAnimating: Bool = false
    @State var secondLabelAnimating: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.opacity(0.7)
                HStack (spacing: 30) {
                    HStack(spacing: 6) {
                        FlipClockSingleTimeView(lastTimeNumber: $hourTimeUnit.preTenLocationNum, nextTimeNumber: $hourTimeUnit.tenLocationNum,animating: $hourTimeUnit.firstLocationNeedAnimation)

                        ZStack {
                            FlipClockSingleTimeView(lastTimeNumber: $hourTimeUnit.preOneLocationNum, nextTimeNumber: $hourTimeUnit.oneLocationNum, animating: $hourTimeUnit.secondLocationNeedAnimation)
                        }
                    }

                    HStack(spacing: 6) {
                        FlipClockSingleTimeView(lastTimeNumber: $minuteTimeUnit.preTenLocationNum, nextTimeNumber: $minuteTimeUnit.tenLocationNum,animating: $minuteTimeUnit.firstLocationNeedAnimation)

                        FlipClockSingleTimeView(lastTimeNumber: $minuteTimeUnit.preOneLocationNum, nextTimeNumber: $minuteTimeUnit.oneLocationNum, animating: $minuteTimeUnit.secondLocationNeedAnimation)
                    }

                    HStack(spacing: 6) {
                        FlipClockSingleTimeView(lastTimeNumber: $secondTimeUnit.preTenLocationNum, nextTimeNumber: $secondTimeUnit.tenLocationNum,animating: $secondTimeUnit.firstLocationNeedAnimation)
                         
                        FlipClockSingleTimeView(lastTimeNumber: $secondTimeUnit.preOneLocationNum, nextTimeNumber: $secondTimeUnit.oneLocationNum, animating: $secondTimeUnit.secondLocationNeedAnimation)
                    }
                }
            }
            .onReceive(timerToAnimation) { input in
                hourTimeUnit.updateTimeUnit(newTime: TimeHelper.configHoursUnit(date: input))

                minuteTimeUnit.updateTimeUnit(newTime: TimeHelper.configMinuteUnit(date: input))
                
                secondTimeUnit.updateTimeUnit(newTime: TimeHelper.configSecondUnit(date: input))
            }
            //we can do better here
//            .onChange(of: scenePhase) { newPhase in
//                if newPhase == .active {
//                    timerToAnimation = timerToAnimation.upstream.autoconnect()
//                } else if newPhase == .inactive {
//                } else if newPhase == .background {
//                    timerToAnimation.upstream.connect().cancel()
//                }
//            }
        }
    }
}

struct ZStackViewOrder: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.green)
                .frame(width: 50, height: 50)
                .zIndex(1)

            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
        }
    }
}
    
