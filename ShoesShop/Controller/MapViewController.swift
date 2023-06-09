//
//  MapViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 23/04/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var celsiusLabel: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    @IBOutlet weak var CityLabel: UILabel!
    
    
    var weatherManager = WeatherManager()
     

     
     let locationManager = CLLocationManager()
     let userAnnotation = MKPointAnnotation()
     let  destination = MKPointAnnotation()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         locationManager.delegate = self
         searchTextField.delegate = self
         
         
        
         locationManager.requestWhenInUseAuthorization()
         
         weatherManager.delegate = self
        
         //it is other request for apps that always monitor the users location like sports app tracker!
         
         locationManager.requestLocation()
         setupLocationManager()
         mapView.delegate = self
       
         //setRegionForCities()
         
     }
     func setupLocationManager() {
         locationManager.requestWhenInUseAuthorization()
         
         if #available(iOS 14.0, *) {
             if locationManager.authorizationStatus ==
                 .authorizedWhenInUse {
                 locationManager.delegate = self
                 locationManager.startUpdatingLocation()
                 
             }
         } else {
             // Fallback on earlier versions
         }
     }
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if  let location = locations.last {
             locationManager.stopUpdatingLocation()
             let lat = location.coordinate.latitude
             let lon = location.coordinate.longitude
             weatherManager.fetchWeather(latitude: lat, longtitude: lon)
         }
         
         print(" Got Location Data")
         let userLocation = manager.location?.coordinate
         
         userAnnotation.coordinate = userLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
         userAnnotation.title = "User"
         mapView.addAnnotation(userAnnotation)
         mapView.showAnnotations(self.mapView.annotations, animated: true)
     }
    

     
     @IBAction func rrefreshButtonPressed(_ sender: Any) {
         print("Refresh button pressed")
         mapView.removeAnnotations(mapView.annotations) // Remove all annotations
         mapView.removeOverlays(mapView.overlays) // Remove all overlays
         locationManager.requestLocation() // Request updated user location
     }
    
    @IBAction func rrefreshPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    @IBAction func goButtonPressed(_ sender: Any) {
         getLocationFromAddress(address: searchTextField.text ?? "Prishtina")
         clearMap()
     }
    
     
     func clearMap() {
         mapView.removeOverlays(self.mapView.overlays)
         mapView.removeAnnotation(destination)
     }
     func getLocationFromAddress(address: String) {
         let geocoder = CLGeocoder()
         geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
             if let placemarks = placemarks, let coordinate = placemarks.first?.location?.coordinate {
                 let destination = MKPointAnnotation()
                 destination.coordinate = coordinate
                 destination.title = address
                 self?.mapView.addAnnotation(destination)
                 self?.mapView.showAnnotations(self?.mapView.annotations ?? [], animated: true)
                 self?.drawPath(source: self?.userAnnotation, destination: destination)
             }
         }
     }
     
     func drawPath(source: MKPointAnnotation?, destination: MKPointAnnotation) {
         guard let source = source else { return }
         
         let sourcePlacemark = MKPlacemark(coordinate: source.coordinate)
         let destinationPlacemark = MKPlacemark(coordinate: destination.coordinate)
         
         let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
         let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
         
         let directionRequest = MKDirections.Request()
         directionRequest.source = sourceMapItem
         directionRequest.destination = destinationMapItem
         directionRequest.transportType = .automobile
         
         let direction = MKDirections(request: directionRequest)
         
         direction.calculate { [weak self] response, error in
             guard let self = self, let calculationResponse = response else { return }
             
             let routes = calculationResponse.routes
             
             for route in routes {
                 print("route = \(route.name), distance = \(route.distance / 1000)km")
 //                self
                 self.mapView.addOverlay(route.polyline, level: .aboveRoads)
             }
         }
     }
     
     
     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = .red
         renderer.lineWidth = 3
         print("Rendering overlay")
         return renderer
     }
     
     
     
 
     func didFailWithError(error: Error) {
         print(error)
     }
 }
extension MapViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true

    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension MapViewController: WeatherManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        manager.requestLocation() // Refresh the location after an error occurs
        
        
    }
    

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.CityLabel.text = weather.cityName
        }
        
     
    }
}
