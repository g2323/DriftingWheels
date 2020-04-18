//
//  ServerManager.swift
//  DriftingWheels
//
//  Created by Dr. Nürnberg on 10.04.20.
//  Copyright © 2020 G2323. All rights reserved.
//

import Foundation
import Combine

final class HttpPostCommand: ObservableObject {
    
    @Published var currentAction = "NONE"
    
    func postCommand(action: String) {
        guard let url = URL(string: "http://iot.g2323.org/api/device/LE910/command") else {
            return
        }
        
        var device: Device? = DeviceList.sharedInstance.appDeviceList.firstObject as? Device // TODO: nur zum ausprobieren
        if (device == nil) {
            device = Device(deviceid: "LE910", action: action, track: [])
            DeviceList.sharedInstance.appDeviceList.add(device!)
        } else {
            device!.action = action
        }
        
        let jsonEncoder = JSONEncoder()
        let body = try! jsonEncoder.encode(device!)
        
        //let bodyData: [String: String] = ["deviceid": "LE910","action": action]
        //let body = try! JSONSerialization.data(withJSONObject: bodyData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            DispatchQueue.main.async {
                self.currentAction = action
            }
        }.resume()
    }
}

