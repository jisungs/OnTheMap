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
import CoreLocation

class MapViewController:UIViewController {

    var studentLocation: ParseStudent?
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var annotations = [MKPointAnnotation]()
    
    var pin: AnnotatinoPin!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        //let coordinate = CLLocationCoordinate2D(latitude: 35.2285451, longitude: 128.889351)
        //let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 1000000)
        //mapView.setRegion(region, animated: true)
        
        //pin = AnnotatinoPin(title: "My Location", subtitle: "Why other Students location isn't showing? ", coordinate: coordinate)
        //mapView.addAnnotation(pin)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()

    }
    
    //MARK: refreshData()
    func refreshData(){
        //get activity inspector
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        
    }
    
    
    func removeAnnoations(){
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        stopActivityIndicator(for: self, activityIndicator)
    }
    
    func addAnnotationsToMapView(locations: [ParseStudent]){
        
        removeAnnoations()
        
        for dictionary in locations {
            let lat = CLLocationDegrees(dictionary.latitude!)
            let long = CLLocationDegrees(dictionary.longitude!)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 100)
            mapView.setRegion(region, animated: true)
            
            let first = dictionary.firstName!
            let last = dictionary.lastName!
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(String(describing: first)) \(String(describing: last))"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
        
    }
    
    func alert(message: String){
        
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
