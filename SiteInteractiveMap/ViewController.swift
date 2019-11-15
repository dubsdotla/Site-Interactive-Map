//
//  ViewController.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var park = Park(fileName: "park")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let overlayTopLeftCoordinate = park.overlayTopLeftCoordinate
        let overlayBottomRightCoordinate = park.overlayBottomRightCoordinate
        let midCoordinate = park.midCoordinate

        let latDeltaLat: CLLocationDegrees  = overlayTopLeftCoordinate.latitude - overlayBottomRightCoordinate.latitude
        let latDeltaLong: CLLocationDegrees  = overlayTopLeftCoordinate.longitude - overlayBottomRightCoordinate.longitude
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: fabs(latDeltaLat), longitudeDelta: fabs(latDeltaLong))
        let region = MKCoordinateRegion(center: midCoordinate, span: span)
                
        mapView.setRegion(region, animated: false)
        
        let rect = MKMapRectForCoordinateRegion(region: region)
        let overlay = ParkOverlay(coord: midCoordinate, rect: rect)
        mapView.addOverlay(overlay, level: .aboveLabels)
        
        var zoomspan: MKCoordinateSpan = mapView.region.span
        zoomspan.latitudeDelta *= 0.3
        zoomspan.longitudeDelta *= 0.3
        let zoomregion: MKCoordinateRegion = MKCoordinateRegion(center: midCoordinate, span: zoomspan)
        mapView.setRegion(zoomregion, animated: true)
        
        addCampsiteMarkers()
    }
    
    func addCampsiteMarkers() {
        guard let data = Park.json("campsites") as Data?, let json = try? JSON(data: data) else {
            return
        }
        
        let campsiteJSONArray: Array<JSON> = json["campsites"].arrayValue
        
        for campsiteJSON in campsiteJSONArray {
            let campsite = Campsite()
            campsite.name = campsiteJSON["name"].stringValue
            campsite.latitude = campsiteJSON["latitude"].doubleValue
            campsite.longitude = campsiteJSON["longitude"].doubleValue
            campsite.description = campsiteJSON["description"].stringValue
            
            let coordinate = CLLocationCoordinate2DMake(campsite.latitude, campsite.longitude)

            let campsiteAnnotation = ParkAnnotation(coordinate: coordinate, title: campsite.name, subtitle:  campsite.description, phone: 0, type: ParkAnnotationType.campsite)
            mapView.addAnnotation(campsiteAnnotation)
            
            let camper = Camper()
            camper.name = camper.generateName()
            camper.phone = 5555555555
            camper.description = campsite.description
            
            let camperAnnotation = ParkAnnotation(coordinate: coordinate, title: camper.name, subtitle:  campsite.description, phone:camper.phone, type: ParkAnnotationType.camper)
            mapView.addAnnotation(camperAnnotation)
        }
    }
    
    func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))

        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)

        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is ParkOverlay {
            let image = UIImage(named: "GlacierNPMap_NPS")!
            return ParkOverlayRenderer(image: image, overlay: overlay)
        }
            
        else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           let annotationView = ParkAnnotationView(annotation: annotation, reuseIdentifier: "ParkAnnotation")
           annotationView.canShowCallout = true
        
           return annotationView
       }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if let parkAnnotation = view.annotation as? ParkAnnotation {
                if parkAnnotation.type == ParkAnnotationType.camper {
                    view.superview?.bringSubviewToFront(view)
                }
            }
        }
    }
}
