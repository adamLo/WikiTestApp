//
//  CustomLocation.swift
//  WikiTestApp
//
//  Created by Adam Lovastyik on 27/10/2019.
//  Copyright © 2019 Adam Lovastyik. All rights reserved.
//

import Foundation
import CoreLocation

/// Custom location structure to list and add
struct CustomLocation {
    
    /// Title of location
    let title: String
    
    /// Coordinate of location
    let coordinate: CLLocationCoordinate2D
    
    /// Initializes a location with a pair of coordinates separated by comma. Fails to initialize if requirements not met
    init?(coordinates: String?) {
        
        // Check if provided string can be split to 2 coordinates
        guard let components = coordinates?.split(separator: ","), components.count == 2 else {return nil}
            
        // Check if componets are valid numbers
        let latitudeString = components[0]
        let longitudeString = components[1]
        guard let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {return nil}
        
        // Check if coordinates are valid at all
        let _coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        guard CLLocationCoordinate2DIsValid(_coordinate) else {return nil}
                
        // Yup, everything looks good
        coordinate = _coordinate
        title = "Custom location"
    }
    
    /// Initializes a custom location with title and coorinate
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
    }
    
    /// Constructs URL to open modified wikipedia app
    var wikiURL: URL? {
        return URL(string: "wikipedia://places?LACoordinate=\(coordinate.latitude),\(coordinate.longitude)")
    }
}
