//
//  Converter.swift
//  SolarLunar
//
//  Created by liubo on 2018/3/19.
//  Copyright © 2018年 cloudist. All rights reserved.
//

import Foundation

struct Converter {
    
    struct ConvertError: Error {
        let message: String
        
        init(message: String) {
            self.message = message
        }
    }
    
    static let formatter = DateFormatter()
    
    private static let LUNAR_INFO: [Int] = [
        0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
        0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977,
        0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970,
        0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950,
        0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557,
        0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0,
        0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0,
        0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
        0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570,
        0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0,
        0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5,
        0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930,
        0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530,
        0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45,
        0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0
    ]
    private static let START_DATE: String = "19000130"
    // 允许输入的最小年份
    private static let MIN_YEAR: Int = 1900
    // 允许输入的最大年份
    private static let MAX_YEAR: Int = 2049
//    private static var isLeapYear: Bool = false
    
    private static func daysBetween(_ startDate: Date, _ endDate: Date) throws -> Int {
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        guard let days = components.day else {
            throw ConvertError(message: "计算两个日期间隔天数出错")
        }
        return days
    }
    
    private static func getYearDays(year: Int) -> Int {
        var sum: Int = 29 * 12
        var i = 0x8000
        while i >= 0x8 {
            if (LUNAR_INFO[year - 1900] & 0xfff0 & i) != 0 {
                sum += 1
            }
            i >>= 1
        }
        return sum + getLeapMonthDays(year: year)
    }
    
    private  static func getLeapMonth(year: Int) -> Int {
        return LUNAR_INFO[year - 1900] & 0xf
    }
    
    private static func getLeapMonthDays(year: Int) -> Int {
        if getLeapMonth(year: year) != 0 {
            if (LUNAR_INFO[year - 1900] & 0xf0000) == 0 {
                return 29
            } else {
                return 30
            }
        } else {
            return 0
        }
    }
    
    private static func getMonthDays(lunarYear: Int, month: Int) throws -> Int {
        if lunarYear > 2049 {
            throw ConvertError(message: "年份有错")
        }
        
        if month > 12 || month < 1 {
            throw ConvertError(message: "月份有错！")
        }
        
        let bit = 1 << (16 - month)
        if ((LUNAR_INFO[lunarYear - 1900] & 0x0FFFF) & bit) == 0 {
            return 29
        }
        return 30
    }
 
    private static func checkLunarDate(_ lunarYear: Int, _ lunarMonth: Int, _ lunarDay: Int, leapMonthFlag: Bool) throws {
        if lunarYear < MIN_YEAR || lunarYear > MAX_YEAR {
            throw ConvertError(message: "非法农历年份!")
        }
        
        if lunarMonth < 1 || lunarMonth > 12 {
            throw ConvertError(message: "非法农历月份!")
        }
        
        if lunarDay < 1 || lunarDay > 30 {
            throw ConvertError(message: "非法农历天数!")
        }
        
        let leap = getLeapMonth(year: lunarYear)
        if leapMonthFlag == true && lunarMonth != leap {
            throw ConvertError(message: "非法闰月!")
        }
    }
    
    static func lunar(from solar: Solar) throws -> Lunar {
        var i: Int = 0
        var temp: Int = 0
        var lunarYear: Int
        var lunarMonth: Int //农历月份
        var lunarDay: Int //农历当月第几天
        var leapMonthFlag: Bool = false
        var isLeapYear: Bool = false
        
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "zh_Hans_SG")
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        
        let solarDateString = String(format: "%04d%02d%02d", solar.year, solar.month, solar.day)
        guard let myDate = formatter.date(from: solarDateString), let startDate = formatter.date(from: START_DATE) else {
            throw ConvertError(message: "公历日期错误")
        }
        
        var offset = try daysBetween(startDate, myDate)
        
        i = MIN_YEAR
        
        while i <= MAX_YEAR {
            temp = getYearDays(year: i)
            if offset - temp < 1 {
                break
            } else {
                offset -= temp
            }
            i += 1
        }
        
        lunarYear = i
        
        let leapMonth = getLeapMonth(year: lunarYear)
        
        if leapMonth > 0 {
            isLeapYear = true
        } else {
            isLeapYear = false
        }
        
        i = 1
        while i <= 12 {
            if i == leapMonth + 1 && isLeapYear {
                temp = getLeapMonthDays(year: lunarYear)
                isLeapYear = false
                leapMonthFlag = true
                i -= 1
            } else {
                temp = try getMonthDays(lunarYear: lunarYear, month: i)
            }
            offset -= temp
            if offset <= 0 {
                break
            }
            i += 1
        }
        
        offset += temp
        lunarMonth = i
        lunarDay = offset
        
        let isLeap = (leapMonthFlag & (lunarMonth == leapMonth))
        let lunar = Lunar(year: lunarYear, month: lunarMonth, day: lunarDay, isLeap: isLeap)
        return lunar
    }
    
    static func solar(from lunar: Lunar) throws -> Solar {
        let lunarYear = lunar.year
        let lunarMonth = lunar.month
        let lunarDay = lunar.day
        let leapMonthFlag = lunar.isLeap
        
        try checkLunarDate(lunarYear, lunarMonth, lunarDay, leapMonthFlag: leapMonthFlag)
        
        var offset: Int = 0
        for i in MIN_YEAR ..< lunarYear {
            let yearDaysCount = getYearDays(year: i) // 求阴历某年天数
            offset += yearDaysCount
        }
        //计算该年闰几月
        let leapMonth = getLeapMonth(year: lunarYear)
        
        if leapMonthFlag && (leapMonth != lunarMonth) {
            throw ConvertError(message: "您输入的闰月标志有误")
        }
        
        //当年没有闰月或月份早于闰月或和闰月同名的月份
        if leapMonth == 0 || (lunarMonth < leapMonth) || (lunarMonth == leapMonth && !leapMonthFlag) {
            for i in 1 ..< lunarMonth {
                let tempMonthDaysCount = try getMonthDays(lunarYear: lunarYear, month: i)
                offset += tempMonthDaysCount
            }
            
            // 检查日期是否大于最大天
            if lunarDay > (try getMonthDays(lunarYear: lunarYear, month: lunarMonth)) {
                throw ConvertError(message: "不合法的农历日期")
            }
            offset += lunarDay // 加上当月的天数
        } else { //当年有闰月，且月份晚于或等于闰月
            for i in 1 ..< lunarMonth {
                let tempMonthDaysCount = try getMonthDays(lunarYear: lunarYear, month: i)
                offset += tempMonthDaysCount
            }
            if lunarMonth > leapMonth {
                let temp = getLeapMonthDays(year: lunarYear) // 计算闰月天数
                offset += temp // 加上闰月天数
                
                if lunarDay > (try getMonthDays(lunarYear: lunarYear, month: lunarMonth)) {
                    throw ConvertError(message: "不合法的农历日期")
                }
                offset += lunarDay
            } else { // 如果需要计算的是闰月，则应首先加上与闰月对应的普通月的天数
                // 计算月为闰月
                let temp = try getMonthDays(lunarYear: lunarYear, month: lunarMonth) // 计算非闰月天数
                offset += temp
                if lunarDay > getLeapMonthDays(year: lunarYear) {
                    throw ConvertError(message: "不合法的农历日期")
                }
                offset += lunarDay
            }
        }
        
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "zh_Hans_SG")
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        
        guard let d = formatter.date(from: START_DATE) else {
            throw ConvertError(message: "START_DATE 错误")
        }
        var date = d
        date.addTimeInterval(Double(offset) * 24 * 60 * 60)
        date.addTimeInterval(Double(8 * 60 * 60))
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let solar = Solar(year: components.year!, month: components.month!, day: components.day!)
        return solar
    }
}

extension Bool {
    static func &(lhs: Bool, rhs: Bool) -> Bool {
        let a = lhs ? 1 : 0
        let b = rhs ? 1 : 0
        let c = a & b
        return c == 1 ? true : false
    }
    
    static func &(lhs: Bool, rhs: Int) -> Int {
        let a = lhs ? 1 : 0
        let c = a & rhs
        return c
    }
}

