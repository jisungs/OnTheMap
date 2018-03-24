//
//  MapViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 24..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController:UIViewController {
    
    var annotations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    func removeAnnoations(){
        mapView.removeAnnotation(annotations as! MKAnnotation)
        annotations.removeAll()
    }
    
    func addAnnotationsToMapView(locations: [ParseStudent]){
        
        removeAnnoations()
        
        for location in locations {
            let lati = CLLocationDegrees(location.latitude)
            let longti = CLLocationDegrees(location.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lati, longitude: longti)
            
            let first = location.firstName!
            let last = location.lastName!
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusedID = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusedID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else{
        pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let url = view.annotation?.subtitle{
                app.open(URL(string:url!)!, options: [:], completionHandler:{
                    (success) in
                    if !success{
                        self.showAlert("Invalid URL", message: "Could not open URL")
                    }
                })
            }
        }
    }
}


