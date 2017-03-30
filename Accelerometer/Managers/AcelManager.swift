//
//  AcelManager.swift
//  Accelerometer
//
//  Created by Pablo Roca Rozas on 27/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import CoreMotion

open class AcelManager {
    // it converts itself as a singleton
    public static let sharedInstance = AcelManager()
    
    /// This private prevents others from using the default '()' initializer for this class.
    private init() {
    }
    
    var motionManager: CMMotionManager!
    var isCapturing: Bool = false
    var timer = Timer()
    
    // parameters
    
    // time for samples (20hz / 50 ms)
    var timeforSamples: Double = 0.05
    
    // time to refresh the UI
    var timeRefreshUI: Double = 1.0

    open func start() {
        isCapturing = true

        timer = Timer.scheduledTimer(timeInterval: timeRefreshUI, target: self, selector: #selector(self.notifytoUI), userInfo: nil, repeats: true)

        motionManager = CMMotionManager()
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = timeforSamples
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let myData = data
                {
                    // add data
                    DataManager.sharedInstance.addData(accelX: myData.acceleration.x, accelY: myData.acceleration.y, accelZ: myData.acceleration.z)
                }
            }
        }
    }
    
    open func stop() {
        isCapturing = false
        timer.invalidate()
        motionManager.stopAccelerometerUpdates()
    }
    
    // refresh UI using a notification
    @objc func notifytoUI() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AccelerometerRefresh"), object: nil)
        }
    }
    

    
}
