//
//  ViewController.swift
//  Accelerometer
//
//  Created by Pablo Roca Rozas on 27/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segTimeCapture: UISegmentedControl!
    
    @IBOutlet weak var lblmaxX: UILabel!
    @IBOutlet weak var lblmedianX: UILabel!
    @IBOutlet weak var lblmeanX: UILabel!
    @IBOutlet weak var lblstdevX: UILabel!
    @IBOutlet weak var lblminX: UILabel!
    @IBOutlet weak var lblcountX: UILabel!
    @IBOutlet weak var lblcrossingsX: UILabel!
    
    @IBOutlet weak var lblmaxY: UILabel!
    @IBOutlet weak var lblmedianY: UILabel!
    @IBOutlet weak var lblmeanY: UILabel!
    @IBOutlet weak var lblstdevY: UILabel!
    @IBOutlet weak var lblminY: UILabel!
    @IBOutlet weak var lblcountY: UILabel!
    @IBOutlet weak var lblcrossingsY: UILabel!
    
    @IBOutlet weak var lblmaxZ: UILabel!
    @IBOutlet weak var lblmedianZ: UILabel!
    @IBOutlet weak var lblmeanZ: UILabel!
    @IBOutlet weak var lblstdevZ: UILabel!
    @IBOutlet weak var lblminZ: UILabel!
    @IBOutlet weak var lblcountZ: UILabel!
    @IBOutlet weak var lblcrossingsZ: UILabel!
    
    @IBOutlet weak var btnStartCapture: UIButton!
    
    
    var isCapturing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateUI), name:NSNotification.Name(rawValue: "AccelerometerRefresh"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "AccelerometerRefresh"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UI Actions
    
    @IBAction func btnStartCaptureTouched(_ sender: Any) {
        AcelManager.sharedInstance.isCapturing = !AcelManager.sharedInstance.isCapturing
        if AcelManager.sharedInstance.isCapturing {
            btnStartCapture.setTitle("Stop Capture", for: .normal)
            DataManager.sharedInstance.clearData()
            AcelManager.sharedInstance.start()
        } else {
            btnStartCapture.setTitle("Start Capture", for: .normal)
            AcelManager.sharedInstance.stop()
        }
    }
    
    // Custom methods
    
    func updateUI() {
        
        var valuesX: [Double] = []
        var valuesY: [Double] = []
        var valuesZ: [Double] = []
        
        if segTimeCapture.selectedSegmentIndex == 0 {
            // time frame
            valuesX = DataManager.sharedInstance.statsfor(secondstoCheck: Constants.timeCapture, array: DataManager.sharedInstance.arrX)
            valuesY = DataManager.sharedInstance.statsfor(secondstoCheck: Constants.timeCapture, array: DataManager.sharedInstance.arrY)
            valuesZ = DataManager.sharedInstance.statsfor(secondstoCheck: Constants.timeCapture, array: DataManager.sharedInstance.arrZ)
        } else {
            //overall
            valuesX = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrX)
            valuesY = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrY)
            valuesZ = DataManager.sharedInstance.statsfor(secondstoCheck: 0, array: DataManager.sharedInstance.arrZ)
        }
        
        // assign UI
        /// returns - max, median, mean, stdev, min, count, crossings
        lblmaxX.text = String(format: "%.2f", valuesX[0])
        lblmedianX.text = String(format: "%.2f", valuesX[1])
        lblmeanX.text = String(format: "%.2f", valuesX[2])
        lblstdevX.text = String(format: "%.2f", valuesX[3])
        lblminX.text = String(format: "%.2f", valuesX[4])
        lblcountX.text = String(format: "%d", Int(valuesX[5]))
        lblcrossingsX.text = String(format: "%d", Int(valuesX[6]))
        
        lblmaxY.text = String(format: "%.2f", valuesY[0])
        lblmedianY.text = String(format: "%.2f", valuesY[1])
        lblmeanY.text = String(format: "%.2f", valuesY[2])
        lblstdevY.text = String(format: "%.2f", valuesY[3])
        lblminY.text = String(format: "%.2f", valuesY[4])
        lblcountY.text = String(format: "%d", Int(valuesY[5]))
        lblcrossingsY.text = String(format: "%d", Int(valuesY[6]))
        
        lblmaxZ.text = String(format: "%.2f", valuesZ[0])
        lblmedianZ.text = String(format: "%.2f", valuesZ[1])
        lblmeanZ.text = String(format: "%.2f", valuesZ[2])
        lblstdevZ.text = String(format: "%.2f", valuesZ[3])
        lblminZ.text = String(format: "%.2f", valuesZ[4])
        lblcountZ.text = String(format: "%d", Int(valuesZ[5]))
        lblcrossingsZ.text = String(format: "%d", Int(valuesZ[6]))
    }
    
    @IBAction func segCaptureTouched(_ sender: Any) {
        self.updateUI()
    }
}
