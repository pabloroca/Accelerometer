//
//  AccelerometerTests.swift
//  AccelerometerTests
//
//  Created by Pablo Roca Rozas on 27/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import XCTest
import CoreMotion

@testable import Accelerometer

class AccelerometerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.sharedInstance.clearData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataAdd() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 1.1, accelZ: 1.2)

        if DataManager.sharedInstance.arrX[0].value == 1.0 && DataManager.sharedInstance.arrY[0].value == 1.1 && DataManager.sharedInstance.arrZ[0].value == 1.2 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }
    
    func testDataMax() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)

        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings

        if stats[0] == 3.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }

    func testDataMedian() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[1] == 2.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }
    
    func testDataMean() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[2] == 2.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }

    func testDataStDev() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[3] == 0.81649658092772603 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }

    func testDataMin() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[4] == 1.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }

    func testDataCount() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 3.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[5] == 3.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }
    
    func testDataCrossings() {
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 2.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: -1.0, accelY: 0, accelZ: 0)
        DataManager.sharedInstance.addData(accelX: 1.0, accelY: 0, accelZ: 0)
        
        let stats = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
        /// returns - max, median, mean, stdev, min, count, crossings
        
        if stats[6] == 2.0 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }

}
