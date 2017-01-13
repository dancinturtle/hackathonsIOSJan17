//
//  distanceCountdown.swift
//  measureApp
//
//  Created by ken bains on 1/12/17.
//  Copyright © 2017 ken bains. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class distanceCountdown: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var countdownInput: UITextField!
    var pedo: CMPedometer?
    var startTime: NSDate!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(distanceCountdown.dismissKeyboard))
        view.addGestureRecognizer(tap)
        pedo = CMPedometer()
        startTime = Date() as NSDate!
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startCountdown(_ sender: UIButton) {
        let text = Int(countdownInput.text!)
        var progress:Int = 0
        if let tex = text{

            while progress < tex{
                if let ped = pedo {
                    print("The time right now is",Date())
                    
//                    ped.startUpdates(from: Date()){
//                        (data: CMPedometerData?, error: Error?) in
//                        print("Hello???")
//                        if let mydata = data {
//                            print("Data returned", mydata)
//                            print("distance traveled", mydata.distance)
//                        }
//                    }

                    ped.queryPedometerData(from: startTime as Date, to: Date()){
                        (data: CMPedometerData?, error: Error?) in
                        if let mydata = data{
                            print(mydata, "mydata")
                            let distance = mydata.distance?.intValue
                            progress = distance!
                            self.countdownLabel.text = "\(distance!) ft"
                        }
                    }
                }//if ped
            }//while
        }
        dismissKeyboard()
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
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
}
