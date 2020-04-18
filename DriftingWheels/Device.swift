//
//  Device.swift
//  DriftingWheels
//
//  Created by Dr. Nürnberg on 11.04.20.
//  Copyright © 2020 G2323. All rights reserved.
//

import Foundation

struct Device: Codable {
    let deviceid: String
    var action: String
    var track: [GeoPosition]?
}

struct GeoPosition: Codable {
    let lat: Double
    let lon: Double
}
