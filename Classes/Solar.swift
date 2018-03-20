//
//  Solar.swift
//  SolarLunar
//
//  Created by liubo on 2018/3/19.
//  Copyright © 2018年 cloudist. All rights reserved.
//

import Foundation

class Solar {
    var year: Int
    var month: Int
    var day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    convenience init() {
        self.init(year: 0, month: 0, day: 0)
    }
    
    func toLunar() throws -> Lunar {
        return try Converter.lunar(from: self)
    }
}

extension Solar: Comparable {
    static func <(lhs: Solar, rhs: Solar) -> Bool {
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
    
    static func ==(lhs: Solar, rhs: Solar) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
}
