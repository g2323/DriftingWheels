//
//  DeviceList.swift
//  DriftingWheels
//
//  Created by Dr. Nürnberg on 11.04.20.
//  Copyright © 2020 G2323. All rights reserved.
//

import Foundation
import CoreData


// ein Protokoll um den jeweils aktiven ViewController zu akzualisieren
protocol DeviceListDelegate: class {
    func didUpdateDeviceList()
}

// singleton app device list
// das Ding muss!!! von NSObject erben, damit der Timer oder konkret der Selector funktioniert
open class DeviceList : NSObject {
    
    let outdoorTimeInterval:TimeInterval = 120.0
    var outdoorTimer: Timer = Timer()
     
    weak var delegate: DeviceListDelegate?
    
    class var sharedInstance: DeviceList {
        struct Static {
            static let sharedIstance: DeviceList = DeviceList()
        }
        return Static.sharedIstance
    }

    let appDeviceList: NSMutableArray = NSMutableArray()
    
    
    // GCD
    let concurrentDeviceListQueue = DispatchQueue(label: "de.g2323.iot.deviceListQueue", attributes: DispatchQueue.Attributes.concurrent)


    
    func updateDeviceList() {
        //print("updateDeviceList")
        self.delegate?.didUpdateDeviceList()
    }
    
    
    
    //start Timer to read WebService for DeviceList
    func startTimer() {
        outdoorTimer = Timer.scheduledTimer(timeInterval: outdoorTimeInterval, target: self, selector: #selector(DeviceList.outdoorTimerSchedule(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func outdoorTimerSchedule(_ timer:Timer!) {
        //print("DeviceList: timerSchedule")
        
        //self.readDeviceListWebService()
        
        //self.readRoutesForSelectedDevices()
        
       
    }
    
}
