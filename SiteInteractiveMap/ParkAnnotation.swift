//
//  CampsiteAnnotation.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit
import MapKit

enum ParkAnnotationType: Int {
    case campsite
    case camper
}

class ParkAnnotation: NSObject, MKAnnotation  {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var phone: Int = 0
    var type: ParkAnnotationType
   
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, phone:Int, type:ParkAnnotationType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.phone = phone
        self.type = type
    }
}
