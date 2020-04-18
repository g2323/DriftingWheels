//
//  MapView.swift
//  DriftingWheels
//
//  Created by Dr. Nürnberg on 10.04.20.
//  Copyright © 2020 G2323. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var locationManager = CLLocationManager()
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupLocationManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .follow
        mapView.mapType = .hybridFlyover
    
        
        
        mapView.delegate = context.coordinator
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(gestureReconizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView
        
        init(_ control: MapView) {
            self.control = control
            
            
            
        }
        
        @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
            if gestureReconizer.state == .ended {
                
                if let mapView = gestureReconizer.view as? MKMapView {
                    let point = gestureReconizer.location(in: mapView)
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mapView.addAnnotation(annotation)
                    
                    var device: Device? = DeviceList.sharedInstance.appDeviceList.firstObject as? Device // TODO: nur zum ausprobieren
                    let pos = GeoPosition(lat: coordinate.latitude, lon: coordinate.longitude)
                    
                    if (device == nil) {
                        device = Device(deviceid: "LE910", action: "START", track: [pos])
                        DeviceList.sharedInstance.appDeviceList.add(device!)
                    } else {
                        device!.track?.append(pos)
                        DeviceList.sharedInstance.appDeviceList.replaceObject(at: 0, with: device!)
                    }
                    
                                 
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
