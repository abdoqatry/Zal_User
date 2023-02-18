//
//  LocationManger.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject{
    
    // MARK: - Singleton
    static let SharedInstans = LocationManager()

    // MARK: - Properties
    var locationManager: CLLocationManager!
    
    
    override init(){
        super.init()
        setuoLocationManager()
    }
    
    // MARK: - Configuration
    private func setuoLocationManager() {
        locationManager = CLLocationManager();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func LocationIsEnable()->Bool{
        if locationManager.location != nil {
            return true
        } else {
            return false
        }
    }
    
    func getlongitude()->Double{
        return (locationManager.location?.coordinate.longitude ?? 0.0)
    }
    
    func getlatitude()->Double{
        return  (locationManager.location?.coordinate.latitude ?? 0.0)
    }
    
    
    func getCurrentCordinate()->String{
        var lat = String(getlatitude())
        lat.insert(",", at: lat.index(lat.startIndex, offsetBy: 2))
        var long = String(getlongitude())
        long.insert(",", at: long.index(lat.startIndex, offsetBy: 2))
        return ("\(lat),\(long)")
    }
   
    
    func calculateDistance(destinationLat:Double,destinationLog:Double)->CLLocationDistance{
        let coordinateSource = CLLocation(latitude: getlatitude(), longitude: getlongitude())
        let coordinateDistination = CLLocation(latitude: destinationLat, longitude: destinationLog)
        return Double(round(1000*coordinateSource.distance(from: coordinateDistination))/1000)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        calculateDistance(destinationLat: <#T##Double#>, destinationLog: <#T##Double#>)
    }
    
    func getOldLocation(Lat:Double,long:Double){
        
    }
    
}



