//
//  CustomOverlayRenderer.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit
import MapKit

class ParkOverlay: NSObject, MKOverlay {

    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect

    init(coord: CLLocationCoordinate2D, rect: MKMapRect) {
        self.coordinate = coord
        self.boundingMapRect = rect
    }
}

class ParkOverlayRenderer: MKOverlayRenderer {
    
    var overlayImage: UIImage
    
    init(image: UIImage, overlay: MKOverlay) {
        self.overlayImage = image
        super.init(overlay: overlay)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let image = overlayImage.cgImage
        let rect = self.rect(for: overlay.boundingMapRect)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -rect.size.height)
        context.draw(image!, in: rect)
    }
}
