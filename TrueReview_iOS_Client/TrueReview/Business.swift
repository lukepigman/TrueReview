//
//  Business1.swift
//  TrueReview
//
//  Created by Luke Pigman on 4/15/19.
//  Copyright © 2019 Billy Lim. All rights reserved.
//

import Foundation
import Alamofire


class Business{

struct Root : Decodable {
    let businesses : [Business]
}

// Name this kind of struct in singular form

    struct Business : Codable {
        
        let alias: String
        let categories : [Categories]
        let coordinates: Coordinates
        let name: String
        let image_url: URL
        let is_closed: Bool
        let url: String
        let review_count: Int
        let id: String
        let rating: Double
        
        let transactions: [String]

        let location: Location
        let phone: String
        let display_phone: String
        let distance: Double

            struct Coordinates : Codable {
                let latitude: Double
                let longitude: Double
            }
    
            struct Categories: Codable{
                let alias: String
                let title: String
            }

        struct Location : Codable {
            let address1: String
            let city, zip_code, country, state: String
            let display_address: [String]
        }
    }
}

