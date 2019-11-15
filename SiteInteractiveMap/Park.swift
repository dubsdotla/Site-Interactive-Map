//
//  Park.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit
import MapKit

class Park {
    
    var name: String = ""
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate = CLLocationCoordinate2D()
    var midCoordinate = CLLocationCoordinate2D()
    
    class func json(_ json: String) -> Data? {
        let filePath = Bundle.main.path(forResource: json, ofType: "json")!
        let data = FileManager.default.contents(atPath: filePath)!
                
        return data
    }
    
    init(fileName: String) {
        guard let data = Park.json(fileName) as Data?, let json = try? JSON(data: data) else {
            return
        }
        
        name = json["name"].stringValue

        midCoordinate.latitude = json["midpoint"]["latitude"].doubleValue
        midCoordinate.longitude = json["midpoint"]["longitude"].doubleValue

        overlayTopLeftCoordinate.latitude = json["topleft"]["latitude"].doubleValue
        overlayTopLeftCoordinate.longitude = json["topleft"]["longitude"].doubleValue

        overlayBottomRightCoordinate.latitude = json["bottomright"]["latitude"].doubleValue
        overlayBottomRightCoordinate.longitude = json["bottomright"]["longitude"].doubleValue
    }
}
