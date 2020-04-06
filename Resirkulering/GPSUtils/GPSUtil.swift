//
//  GPSUtil.swift
//
//  Created by Borgar Grande on 07/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//
//

import Foundation
import CoreLocation

class GPSUtil: NSObject, CLLocationManagerDelegate{
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let semaphore = DispatchSemaphore(value: 0)
    
    
    
    func getLocation(completion: @escaping (_ lat: String, _ lng: String) -> Void) {
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        self.locManager.requestAlwaysAuthorization()
        self.locManager.startUpdatingLocation()
        
        DispatchQueue.global(qos: .background).async {
            self.semaphore.wait()
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
                self.currentLocation = self.locManager.location
                let latitude = String(format: "%.7f", self.currentLocation.coordinate.latitude)
                let longitude = String(format: "%.7f", self.currentLocation.coordinate.longitude)
                _ = CLLocation(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
                completion(latitude, longitude)}
            else {
                
                completion("","")
            }
            self.locManager.stopUpdatingLocation()
            self.semaphore.signal()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .denied:
            semaphore.signal()
            break
        case .notDetermined:
            break
        case .restricted:
            break
        default:
            semaphore.signal()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        semaphore.signal()
    }
}

