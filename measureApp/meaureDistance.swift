//
//  meaureDistance.swift
//  measureApp
//
//  Created by ken bains on 1/12/17.
//  Copyright © 2017 ken bains. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class measureDistance: UIViewController {
    
    var pedo: CMPedometer?
    var startTime: NSDate!
    var buttonArray: [String] = ["Start Walking", "Stop"]

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startWalkingPressed: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    func getCurrentLocalDate()-> Date {
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = Calendar.current.component(.hour, from: now)
        nowComponents.minute = Calendar.current.component(.minute, from: now)
        nowComponents.second = Calendar.current.component(.second, from: now)
        nowComponents.timeZone = TimeZone(abbreviation: "PST")!
        now = calendar.date(from: nowComponents)!
        return now as Date
    }
    
    
    
    @IBAction func startWalkingPressed(_ sender: UIButton) {
        startTime = Date() as NSDate!
        startWalkingPressed.isHidden = true
        stopButton.isHidden = false
        distanceLabel.isHidden = false
        distanceLabel.text = "Getting Data"
        pedo = CMPedometer()
        
        
        

    }
    
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if let ped = pedo {
            ped.queryPedometerData(from: startTime as Date, to: Date()){
                (data: CMPedometerData?, error: Error?) in
                if let mydata = data{
                    print(mydata, "mydata")
                    let distance = mydata.distance?.stringValue
                    let pi: Double = Double(distance!)!
                    let fin = String(format:"%.2f", pi)
                    self.distanceLabel.text = "\(fin) ft"

                }
            }
            startWalkingPressed.isHidden = false
            stopButton.isHidden = true
            distanceLabel.text = "Calculating..."
        }
        else{
            print("no you idiot")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isHidden = true
        print("View did load")
        distanceLabel.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "measurebackground.png")!)

//        distanceLabel.layer.borderWidth = 1.0
//        distanceLabel.layer.borderColor = UIColor.black.cgColor
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
  
}
