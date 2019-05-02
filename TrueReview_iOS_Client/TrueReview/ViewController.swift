//
//  ViewController.swift
//  Mapkit-InClass
//
//  Created by Billy Lim on 3/20/18.
//  Copyright © 2018 Billy Lim. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
   //var initialLocation = CLLocation?
    var currentLocation: CLLocation!
    let regionRadius: CLLocationDistance = 3000 // 1000 meters: a little more than half a mile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
        
            currentLocation = locationManager.location
            
//        }
        
        
        
        mapView.delegate = self
        
        
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.clipsToBounds = true
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        searchBar.layer.cornerRadius = 6.0
        searchBar.layer.borderWidth = 0.1
        
        searchBar.tintColor = UIColor(named: "#555555")
        searchBar.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 50)
        searchBar.placeholder = "Search by category"
        self.view.addSubview(searchBar)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        checkLocationAuthorizationStatus()
        
        let initialLocation = locationManager.location
        currentLocation = initialLocation
//        CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
      centerMapOnLocation(location: initialLocation!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
       let lat = currentLocation.coordinate.latitude
       let long = currentLocation.coordinate.longitude
        print("searchText \(searchBar.text ?? "no text entered") \(lat)  \(long)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer zmd9y3Q30Zj7Ekoh8sokT1bmzw4hWXNfzpjbnjSV5GXhX6v6gKslsx7T645Dm4rBMCv-x5ZKAM_0l7-FlFJS76ev43IWXnDcwyoOwIRVZh2SGyLne_jzL3-LHAbGXHYx",
            "Accept": "application/json"
        ]
        
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search?term=\(searchBar.text!)&latitude=\(lat)&longitude=\(long)&limit=10" , headers: headers ).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            
            let decoder = JSONDecoder()
            do {
                
                
                let business = try decoder.decode(Business.Root.self, from: response.data!)
        
                for biz in business.businesses{
                    
                     let mapItem = Attraction.init(title: biz.name, rating: Int(biz.rating), locationName: biz.name, id: biz.alias, url: biz.url, display_phone: biz.display_phone, coordinate: CLLocationCoordinate2DMake(biz.coordinates.latitude, biz.coordinates.longitude))
                    self.mapView.addAnnotation(mapItem)
                    
                }
                
                
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                
            }
           if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
        
        }
    }
    
    
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
              mapView.showsUserLocation = true
            } else {
              locationManager.requestWhenInUseAuthorization()
            }
    }
    
    
    
    // location argument is the center point, with north-south and east-west spans for the region
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let dvc = segue.destination as? ShowDetailViewController {
                dvc.loco = (sender as? Attraction)!
            }
    
        }
    }
}
extension ViewController: MKMapViewDelegate {
    
    // 1
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 2
        
        guard let annotation = annotation as? Attraction else { return nil }
        
        // 3
        
        let identifier = "marker"
        
        var view: MKMarkerAnnotationView
        
        // 4
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            as? MKMarkerAnnotationView {
            
            dequeuedView.annotation = annotation
            
            view = dequeuedView
            
        } else {
            
            // 5
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            view.canShowCallout = true
            
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            view.rightCalloutAccessoryView = UIButton(type: .infoLight)
           
            
            
        }
        
        return view
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 
                 calloutAccessoryControlTapped control: UIControl) {
        
        let location = view.annotation as! Attraction
        
        self.performSegue(withIdentifier: "detail", sender: location)
        
        
        
    }
    
  
}
