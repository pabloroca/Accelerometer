//
//  DataManager.swift
//  Accelerometer
//
//  Created by Pablo Roca Rozas on 27/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation

open class DataManager {
    
    var arrX: [Measure] = []
    var arrY: [Measure] = []
    var arrZ: [Measure] = []
    
    // it converts itself as a singleton
    public static let sharedInstance = DataManager()
    
    /// This private prevents others from using the default '()' initializer for this class.
    private init() {
    }
    
    open func clearData() {
        arrX = []
        arrY = []
        arrZ = []
    }
    
    open func addData(accelX: Double, accelY: Double, accelZ: Double) {
        let date = Date().timeIntervalSince1970
        arrX.append(Measure.init(date: date, value: accelX))
        arrY.append(Measure.init(date: date, value: accelY))
        arrZ.append(Measure.init(date: date, value: accelZ))
    }
    
    /// statsfor (axis)
    /// returns - max, median, mean, stdev, min, count, crossings
    open func statsfor(secondstoCheck: TimeInterval, array:[Measure]) -> [Double] {
        var arrayfiltered : [Measure] = []

        // we reduce the sample to n secondstoCheck
        if secondstoCheck > 0 {
            let datenow = Date().timeIntervalSince1970
            arrayfiltered = array.filter { (measure) -> Bool in
                return datenow - measure.date <= secondstoCheck
            }
        } else {
            arrayfiltered = array
        }
        
        // we convert to an arry of doubles to process it easier
        let arrayDoubles = arrayfiltered.map { (element) -> Double in
            return element.value
        }
        
        // calculations
        
        // MARK: - Calculations
        
        // max
        let vmax = arrayDoubles.count > 0 ? arrayDoubles.max()! : 0.0
        
        // median
        let vmedian = arrayDoubles.count > 0 ? median(array: arrayDoubles) : 0.0

        // mean
        let vmean = arrayDoubles.count > 0 ? mean(array: arrayDoubles) : 0.0
        
        // calculate min
        let vmin = arrayDoubles.count > 0 ? arrayDoubles.min()! : 0.0
        
        // calculate stardanrd deviation
        let vstdev = arrayDoubles.count > 0 ? standardDeviation(array: arrayDoubles) : 0.0
        
        // calculate crossings
        let vcrossings = arrayDoubles.count > 0 ? crossings(array: arrayDoubles) : 0.0

        return [vmax, vmedian, vmean, vstdev, vmin, Double(arrayfiltered.count), vcrossings]
    }
    
    private func median(array: [Double]) -> Double {
        var sortedResults = array.sorted()
        let midIndex = sortedResults.count / 2
        let median = Double(sortedResults[midIndex])
        return median
    }

    private func mean(array: [Double]) -> Double {
        let sum = array.reduce(0, +)
        let mean = sum / Double(array.count)
        return mean
    }
    
    private func standardDeviation(array : [Double]) -> Double
    {
        let length = Double(array.count)
        let avg = array.reduce(0, {$0 + $1}) / length
        let sumOfSquaredAvgDiff = array.map { pow($0 - avg, 2.0)}.reduce(0, {$0 + $1})
        return sqrt(sumOfSquaredAvgDiff / length)
    }
    
    private func crossings(array : [Double]) -> Double {
        var count: Double = 0
        guard array.count > 0 else {
            return 0.0
        }
        var prevalue = array[0]
        for elem in array {
            if prevalue > 0 && elem < 0 || prevalue < 0 && elem > 0 {
                count = count + 1
            }
            prevalue = elem
        }
        return count
    }
    
}
