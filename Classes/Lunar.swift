//
//  Lunar.swift
//  SolarLunar
//
//  Created by liubo on 2018/3/19.
//  Copyright © 2018年 cloudist. All rights reserved.
//

import Foundation

class Lunar {
    var year: Int
    var month: Int
    var day: Int
    var isLeap: Bool
    
    init(year: Int, month: Int, day: Int, isLeap: Bool) {
        self.year = year
        self.month = month
        self.day = day
        self.isLeap = isLeap
    }
    convenience init() {
        self.init(year: 0, month: 0, day: 0, isLeap: false)
    }
    
    func toSolar() throws -> Solar {
        return try Converter.solar(from: self)
    }
}

extension Lunar: Comparable {
    static func <(lhs: Lunar, rhs: Lunar) -> Bool {
        if lhs.year < rhs.year {
            return true
        } else if lhs.year > rhs.year {
            return false
        } else {
            if lhs.month < rhs.month {
                return true
            } else if lhs.month > rhs.month {
                return false
            } else {
                if !lhs.isLeap, rhs.isLeap {
                    return true
                } else if lhs.isLeap, !rhs.isLeap {
                    return false
                } else {
                    if lhs.day < rhs.day {
                        return true
                    } else if lhs.day > rhs.day {
                        return false
                    } else {
                        return false
                    }
                }
            }
        }
    }
    
    static func ==(lhs: Lunar, rhs: Lunar) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day && lhs.isLeap == rhs.isLeap
    }
    
    
}
