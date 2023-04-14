//
//  TimeHolder.swift
//  SwiftUIAnimation
//
//  Created by JerryLiu on 2022/11/23.
//

import Foundation

enum FlipClockTimeLocationType {
    case FlipClockTimeLocationTypeHour
    case FlipClockTimeLocationTypeMinute
    case FlipClockTimeLocationTypeSecond
}

class TimeHolder: ObservableObject {
    
    private var currentDate: Date
    
    @Published private(set) var hourUnit : TimeUnit
    @Published private(set) var minuteUnit : TimeUnit
    @Published private(set) var secondUnit : TimeUnit
    
    init(currentDate: Date) {
        self.currentDate = currentDate
        
        self.hourUnit = TimeUnit(time: TimeHelper.configHoursUnit(date: currentDate),unitType: .FlipClockTimeLocationTypeHour)
        self.minuteUnit = TimeUnit(time: TimeHelper.configMinuteUnit(date: currentDate),unitType: .FlipClockTimeLocationTypeMinute)
        self.secondUnit = TimeUnit(time: TimeHelper.configSecondUnit(date: currentDate),unitType: .FlipClockTimeLocationTypeSecond)
    }
}

class TimeHelper {
    
    //寻找 小时、分钟、秒
    public class func configHoursUnit(date:Date) -> Int {
        let calendar = Calendar.current
        let dateComponent: DateComponents = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: date)
        
        return dateComponent.hour ?? 0
    }
    
    public class func configMinuteUnit(date:Date) -> Int {
        let calendar = Calendar.current
        let dateComponent: DateComponents = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: date)
        
        return dateComponent.minute ?? 0
    }
    
    public class func configSecondUnit(date:Date) -> Int {
        let calendar = Calendar.current
        let dateComponent: DateComponents = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: date)
        
        return dateComponent.second ?? 0
    }
}

class TimeUnit : ObservableObject {
    var unitType : FlipClockTimeLocationType = .FlipClockTimeLocationTypeHour
    
    var tenLocationNum : Int = 0 //十位
    var oneLocationNum : Int = 0 //个位
    
    var preTenLocationNum : Int = 0 //十位 上一个数字
    var preOneLocationNum : Int = 0 //个位 上一个数字
    
    @Published var firstLocationNeedAnimation: Bool //十位需要动画
    @Published var secondLocationNeedAnimation: Bool //个位需要动画
    
    init(time: Int, unitType: FlipClockTimeLocationType) {
        self.firstLocationNeedAnimation = false
        self.secondLocationNeedAnimation = false
        self.unitType = unitType
        
        if time >= 0 && time < 100 {
            self.tenLocationNum = time / 10
            self.oneLocationNum = time % 10
            self.preTenLocationNum = time / 10
            self.preOneLocationNum = time % 10
        } else {
            self.tenLocationNum = 0
            self.oneLocationNum = 0
            self.preOneLocationNum = 0
            self.preTenLocationNum = 0
        }
        
        print("初始化TimeUnit 秒: \(oneLocationNum)")
    }
    
    public func updateTimeUnit(newTime: Int) {
        print("更新TimeUnit 秒: \(newTime)")
        // 56 - 57
        if newTime < 0 && newTime >= 100 {
            return
        }
        
        let newFirstNum : Int = newTime / 10
        let newSecondNum : Int = newTime % 10
        
        updateTimeFirstUnit(newFirstNum: newFirstNum)
        updateTimeSecondUnit(newSecondNum: newSecondNum)
    }
    
    public func updateTimeFirstUnit(newFirstNum: Int) {
        if newFirstNum == self.tenLocationNum {
            self.firstLocationNeedAnimation = false
            return
        }
        
        let tempFirstLocationTime = calculatePreFirstLocationTime(newFirstNum: newFirstNum, timeUnitType: self.unitType)
        
        if abs(newFirstNum - self.preTenLocationNum) <= 1 {
            self.preTenLocationNum = tempFirstLocationTime
        }
        
        self.tenLocationNum = newFirstNum
        
        if newFirstNum == self.preTenLocationNum {
            //相同
            self.firstLocationNeedAnimation = false
        } else {
            self.firstLocationNeedAnimation = true
        }
    }
    
    public func updateTimeSecondUnit(newSecondNum: Int) {
        if newSecondNum == self.oneLocationNum {
            self.secondLocationNeedAnimation = false
            return
        }
        
        let tempSecondLocationTime = calculatePreSecondLocationTime(newSecondNum: newSecondNum, timeUnitType: self.unitType)
        
        if abs(newSecondNum - self.preOneLocationNum) <= 1 {
            self.preOneLocationNum = tempSecondLocationTime
        }
        
        self.oneLocationNum = newSecondNum
        
        if newSecondNum == self.preOneLocationNum {
            //相同
            self.secondLocationNeedAnimation = false
        } else {
            self.secondLocationNeedAnimation = true
        }
    }
    
    public func calculatePreFirstLocationTime(newFirstNum : Int, timeUnitType: FlipClockTimeLocationType) -> Int {
        var result: Int = 0
        
        if timeUnitType == .FlipClockTimeLocationTypeHour {
            //小时
            //十位 只能是 0-2
            result = newFirstNum == 0 ? 2 : newFirstNum - 1
            
        } else if timeUnitType == .FlipClockTimeLocationTypeMinute ||
                    timeUnitType == .FlipClockTimeLocationTypeSecond {
            //分钟
            //十位 只能是 0-5
            result = newFirstNum == 0 ? 5 : newFirstNum - 1
        }
        return result
    }
    
    public func calculatePreSecondLocationTime(newSecondNum : Int, timeUnitType: FlipClockTimeLocationType) -> Int {
        var result: Int = 0
        
        if timeUnitType == .FlipClockTimeLocationTypeHour {
            //小时
            //十位 只能是 0-4
            result = newSecondNum == 0 ? 4 : newSecondNum - 1
            
        } else if timeUnitType == .FlipClockTimeLocationTypeMinute ||
                    timeUnitType == .FlipClockTimeLocationTypeSecond {
            //分钟
            //十位 只能是 0-9
            result = newSecondNum == 0 ? 9 : newSecondNum - 1
        }
        return result
    }
}
