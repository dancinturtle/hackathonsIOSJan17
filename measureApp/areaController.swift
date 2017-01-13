//
//  areaController.swift
//  measureApp
//
//  Created by ken bains on 1/12/17.
//  Copyright © 2017 ken bains. All rights reserved.
//

import UIKit
import CoreMotion
class areaController: UIViewController {
    var pedo: CMPedometer?
    var startTime: NSDate!

    
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var widthmeasureLabel: UILabel!
    @IBOutlet weak var lengthmeasureLabel: UILabel!
    @IBOutlet weak var areameasureLabel: UILabel!
    
    
    
    @IBOutlet weak var startWidthbtn: UIButton!
    @IBOutlet weak var stopWidthbtn: UIButton!
    @IBOutlet weak var startLengthbtn: UIButton!
    @IBOutlet weak var stopLengthbtn: UIButton!
    @IBOutlet weak var reset: UIButton!
    
    var globalWidth: Double = 0
    var globalLength: Double = 0
    var globalArea: Double = 0
    
    var areaArray:[Int] = []
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopWidthbtn.isHidden = true
        startLengthbtn.isHidden = true
        stopLengthbtn.isHidden = true
        reset.isHidden = true
        pedo = CMPedometer()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "areabackground.png")!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startwidthpressed(_ sender: UIButton) {
        startTime = Date() as NSDate!
        startWidthbtn.isHidden = true
        stopWidthbtn.isHidden = false
    }
    @IBAction func stopWalking(_ sender: Any) {
        if let ped = pedo {
            print("1. Width Stop Pressed at",Date())
            ped.queryPedometerData(from: startTime as Date, to: Date()){
                (data: CMPedometerData?, error: Error?) in
                if let mydata = data{
                    print("2. Width data",mydata)
                    let distance = mydata.distance?.doubleValue
                    if let distance = distance {
                        
                        let pi: Double = Double(distance)
                        let fin = String(format:"%.2f", pi)
                        self.widthmeasureLabel.text = "\(fin) ft"
                        
                        //self.widthmeasureLabel.text = "\(distance) ft"
                        print("3. Distance ", distance)
                        self.globalWidth = distance
                        print("4. global width is", self.globalWidth)
                    }
                    
//                    self.areaArray.append(Int(distance!)!)
//                    if let widthDistance = distance {
//                        self.globalWidth = Int(widthDistance)!
//                    }
//                    else{
//                        print("5. not unwrapped properly")
//                    }
                    
                    
                }
            }
        }//end if pedo
        else{
            print("no you idiot")
        }
        stopWidthbtn.isHidden = true
        startLengthbtn.isHidden = false

    }
    @IBAction func startLength(_ sender: UIButton) {
        startLengthbtn.isHidden = true
        stopLengthbtn.isHidden = false
        startTime = Date() as NSDate!
    }
    @IBAction func stopLength(_ sender: UIButton) {
        stopLengthbtn.isHidden = true
        reset.isHidden = false
        if let ped = pedo {
            print("Length Stop Pressed",Date())
            ped.queryPedometerData(from: startTime as Date, to: Date()){
                (data: CMPedometerData?, error: Error?) in
                if let mydata = data{
                    print("Length data is", mydata)
                    let distance = mydata.distance?.doubleValue
                    if let distance = distance {
                        let pi: Double = Double(distance)
                        let fin = String(format:"%.2f", pi)
                        self.lengthmeasureLabel.text = "\(fin) ft"
                        print("3. Distance ", distance)
                        self.globalLength = distance
                        print("4. global length is", self.globalLength)
                        self.globalArea = self.globalWidth * self.globalLength
                        print("5. area is", self.globalArea)
                        
                        
                        let pis: Double = Double(self.globalArea)
                        let fins = String(format:"%.2f", pis)
                        self.areameasureLabel.text = "\(fins) sq ft"
                    }


                }
            }

        }//end if pedo
        else{
            print("no you idiot")
        }
    }
    @IBAction func reset(_ sender: UIButton) {
        startWidthbtn.isHidden = false
        widthmeasureLabel.text = "0ft"
        lengthmeasureLabel.text = "0ft"
        areameasureLabel.text = "0sqft"
        reset.isHidden = true
//        areaArray = []
    }
}
