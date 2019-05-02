//
//  Attraction.swift
//  Mapkit-InClass
//
//  Created by Billy Lim on 3/20/18.
//  Copyright © 2018 Billy Lim. All rights reserved.
//

import Foundation
import MapKit
import Contacts


class Attraction: NSObject, MKAnnotation {
    
    let title: String?
    
    let rating: Int
    
    let locationName: String
    
    let id: String
    
    let url: String
    
    let display_phone: String
    
    let coordinate: CLLocationCoordinate2D
    

    
    init(title: String, rating: Int, locationName: String, id: String, url: String, display_phone: String,coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.rating = rating
        
        self.locationName = locationName
        
        self.id = id
        
        self.url = url
        
        self.display_phone = display_phone
        
        self.coordinate = coordinate
        
        
        
        super.init()
        
    }
    
    var subtitle: String? {
        
        return "Rating: \(String(describing: rating))"
        
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    // Here you create an MKMapItem from an MKPlacemark.
    // The Maps app is able to read this MKMapItem, and display the right thing.
    
    func mapItem() -> MKMapItem {
        
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = title
    
        
        return mapItem
        
    }
    
}
