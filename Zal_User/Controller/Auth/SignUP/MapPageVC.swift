//
//  MapPageVC.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

protocol Mapprotocole {
    func MapDate(Lat : String,Lon :String, address:String)
}

class MapPageVC: UIViewController {

    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var AddresLabel: UILabel!
    @IBOutlet weak var ConfirmBT: UIButton!
    
    let locationManager = CLLocationManager()
    var marker : GMSMarker!
    var centerMapCoordinate:CLLocationCoordinate2D!
    var lat = 0.0
    var lon = 0.0
    
    var deleget : Mapprotocole?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map".localize
        locationManager.delegate = self
        MapView.delegate = self
        checkLocationServices()
        
        // 2
        if CLLocationManager.locationServicesEnabled() {
          // 3
          locationManager.requestLocation()

          // 4
            MapView.isMyLocationEnabled = true
            MapView.settings.myLocationButton = true
        } else {
          // 5
          locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
        DispatchQueue.global(qos: .background).async {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        self.locationManager.stopUpdatingLocation()
    }
        }
    }
    
    @IBAction func ConfirmButton(_ sender: UIButton) {
        
        deleget?.MapDate(Lat: String(lat), Lon: String(lon), address: AddresLabel.text ?? "")
        navigationController?.popViewController(animated: true)
    }

    
    fileprivate func checkLocationServices(){

            if CLLocationManager.locationServicesEnabled(){

                // Setup our location manager

                locationManager.startUpdatingLocation()

                locationManager.desiredAccuracy = kCLLocationAccuracyBest

                MapView.isMyLocationEnabled = true

                MapView.settings.myLocationButton = true

               

            }else{
                showAlert(title: "Ops You shoud turn on your location".localize, messages: nil, message: nil, selfDismissing: true)
//        createSettingsAlertController(title: "Ops You shoud turn on your location", message: "You shoud turn on your location")

                // Show alert letting the user know they have to turn this on

            }

        }

}




extension MapPageVC: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.requestLocation()

    //5
    MapView.isMyLocationEnabled = true
    MapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

//    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    // 7
    MapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
    reverseGeocode(coordinate:location.coordinate )

  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }

        // 3
        self.AddresLabel.text = lines.joined(separator: "\n")
        
        self.lat = coordinate.latitude
        self.lon = coordinate.longitude
        
        print("\(self.lat)\(self.lon)")

        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }

}



extension MapPageVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//      reverseGeocode(coordinate: position.target)
        
      
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
     //Write your code here...
//        mapView.clear()
//        plotMarker(AtCoordinate: coordinate, onMapView: mapView)
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
//        reverseGeocode(coordinate: coordinate)
     }
    
    private func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView) {
        let marker = GMSMarker(position: coordinate)
        marker.map = vwMap
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        reverseGeocode(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    
   
    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        MapView.clear()
        if marker == nil {
               marker = GMSMarker()
           }
        marker.position = centerMapCoordinate
        marker.map = self.MapView
    }
    
}
