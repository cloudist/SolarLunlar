//
//  SolarLunarTests.swift
//  SolarLunarTests
//
//  Created by liubo on 2018/3/16.
//  Copyright © 2018年 cloudist. All rights reserved.
//

import XCTest
@testable import SolarLunar

class SolarLunarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
    }
    
    func testSolunarToLunar() {
        var lunar: Lunar?
        lunar = try? Solar(year: 2017, month: 7, day: 22).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2017, month: 6, day: 29, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2017, month: 7, day: 23).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2017, month: 6, day: 1, isLeap: true), "wrong")
        
        lunar = try? Solar(year: 2017, month: 8, day: 21).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2017, month: 6, day: 30, isLeap: true), "wrong")
        
        lunar = try? Solar(year: 2018, month: 1, day: 20).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2017, month: 12, day: 4, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2018, month: 3, day: 20).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2018, month: 2, day: 4, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2019, month: 1, day: 5).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2018, month: 11, day: 30, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2019, month: 11, day: 15).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2019, month: 10, day: 19, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2020, month: 1, day: 5).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2019, month: 12, day: 11, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2020, month: 5, day: 27).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2020, month: 4, day: 5, isLeap: true), "wrong")
        
        lunar = try? Solar(year: 2020, month: 7, day: 14).toLunar()
        XCTAssertNotNil(lunar)
        XCTAssertEqual(lunar, Lunar(year: 2020, month: 5, day: 24, isLeap: false), "wrong")
        
        lunar = try? Solar(year: 2018, month: 2, day: 29).toLunar()
        XCTAssertNil(lunar)
        
        lunar = try? Solar(year: 2018, month: 4, day: 31).toLunar()
        XCTAssertNil(lunar)
    }
    
    func testLunarToSolar() {
        var solar: Solar?
        
        solar = try? Lunar(year: 2017, month: 6, day: 27, isLeap: false).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2017, month: 7, day: 20), "wrong")
        
        solar = try? Lunar(year: 2017, month: 6, day: 27, isLeap: true).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2017, month: 8, day: 18), "wrong")
        
        solar = try? Lunar(year: 2017, month: 6, day: 31, isLeap: true).toSolar()
        XCTAssertNil(solar)
        
        solar = try? Lunar(year: 2017, month: 12, day: 8, isLeap: false).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2018, month: 1, day: 24), "wrong")
        
        solar = try? Lunar(year: 2018, month: 3, day: 29, isLeap: false).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2018, month: 5, day: 14), "wrong")
        
        solar = try? Lunar(year: 2018, month: 3, day: 30, isLeap: false).toSolar()
        XCTAssertNil(solar)
        
        solar = try? Lunar(year: 2018, month: 12, day: 30, isLeap: false).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2019, month: 2, day: 4), "wrong")
        
        solar = try? Lunar(year: 2019, month: 12, day: 15, isLeap: false).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2020, month: 1, day: 9), "wrong")
        
        solar = try? Lunar(year: 2020, month: 4, day: 15, isLeap: true).toSolar()
        XCTAssertNotNil(solar)
        XCTAssertEqual(solar, Solar(year: 2020, month: 6, day: 6), "wrong")
        
        solar = try? Lunar(year: 2020, month: 6, day: 15, isLeap: true).toSolar()
        XCTAssertNil(solar)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
