//
//  CampsiteAnnotationView.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit
import MapKit

class ParkAnnotationView: MKAnnotationView {

   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
                
        guard (self.annotation as? ParkAnnotation) != nil else {
            return
        }
        
        if let parkAnnotation = self.annotation as? ParkAnnotation {
            if parkAnnotation.type == ParkAnnotationType.campsite {
                
                clusteringIdentifier = "campsite"
            }
            else {
                clusteringIdentifier = "camper"
            }
        }
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let parkAnnotation = self.annotation as? ParkAnnotation {
            if parkAnnotation.type == ParkAnnotationType.campsite {
                displayPriority = .defaultLow
                image = UIImage(named: "icons8-tent-48")
            }
            else {
                displayPriority = .defaultHigh
                image = UIImage(named: "icons8-customer-30")
            }
        }
    }
}
