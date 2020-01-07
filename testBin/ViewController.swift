//
//  ViewController.swift
//  testBin
//
//  Created by ZIV LEVY on 01/12/2019.
//  Copyright © 2019 Yamasee. All rights reserved.
//

import UIKit
import Yamasee

class ViewController: UIViewController, YamaseeCoreDelegate {
    
    let YM = YamaseeCore.shared
    
    @IBOutlet weak var lblAngle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. set self as YamaseeCoreDelegate
        YM.delegate = self
        
        // 2. call start with api key and baseUrl. if you use proxy
        YM.start(apiKey: "xxx-xxx", baseUrl: "https://server.yamasee-skypath.com")
        
        // 3. login to yamasee server
        YM.login(userId: "e010002", aircraft: "787") { (success, error) in
          
            print (success ? "logged in" : error!)
        }
        
        // 3.1 set flight number
        YM.setFlightNumber(flightNumber: "LY001")
        
        //4. optional - get aircraft types
        let aircrafts: Array<YamaseeAircraftType> = YM.getAircraftTypes()
        aircrafts.forEach { (aircraft) in
            print("\(aircraft.aircraft) - \(aircraft.description)")
        }
        
        //5. get Alert - usually when aircraft position changed (mock)
        let alert = YM.getAlert(lat: 30.4, long: 34.1, altitude: Measurement.init(value: 35000, unit: .feet), heading: Measurement.init(value: 259, unit: .degrees))
        
        print (alert)
        
    }
    
    @IBAction func setAngle(_ sender: Any) {
        //6. when user set correct angle in cradle - notify YamaseeCore
        YM.setAngle()
    }
    
}

// MARK: - YamaseeCoreDelegate
extension ViewController {
    
    func newTurbulenceData(serverUpdateTime: Int) {
        // 8. get notified when new turbulence data received from server (or initiated from cache)
        print("============= TURBULENCE =================")
        print ("New Turbulence data from server @ \(Date(timeIntervalSince1970: TimeInterval(serverUpdateTime)))")
        
        // 9. query turbulence to draw on map
        let turbulenceJSON = YamaseeCore.shared.getTurbulenceGeoJson(altRange: Measurement.init(value: 20000, unit: UnitLength.feet)...Measurement.init(value: 22000, unit: UnitLength.feet), timeSpan: 60, zoomLevel: 1)
  
        print(turbulenceJSON.prefix(1000))
        
        // 9. query turbulence to draw on map
        let turbulenceItems = YamaseeCore.shared.getTurbulence(altRange: Measurement.init(value: 20000, unit: UnitLength.feet)...Measurement.init(value: 22000, unit: UnitLength.feet), timeSpan: 60, zoomLevel: 1)
        
        print(turbulenceItems)
    }
    
    
    func newTrafficData(serverUpdateTime: Int) {
        // 10. get notified when new traffic data received from server
        print("============= TRAFFIC =================")
        print ("New Traffic data from server @ \(Date(timeIntervalSince1970: TimeInterval(serverUpdateTime)))")
        
        // 11. query traffic to draw on map
        let traffic = YM.getTraffic(altRange: Measurement.init(value: 20000, unit: UnitLength.feet)...Measurement.init(value: 52000, unit: UnitLength.feet))
        
        print (traffic.count > 10 ? traffic[1...10] : traffic)
        
        
        
    }
    
    // 7. get notified when angle status changed
    func deviceAngleStatusChanged(isInAngle: Bool) {
        lblAngle.text = isInAngle ? "Angle Good" : "Angel Bad"
        lblAngle.textColor = isInAngle ? UIColor.green : UIColor.red
        
    }
    
    // 12. get notified when angle status changed
    func yamaseeCoreNotification(notification: YamaseeCoreNotifications) {
        
    }
}

