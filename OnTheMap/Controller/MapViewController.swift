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
    
    var studentLocation: ParseStudent?
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    let locations = [ParseStudent]()
    
    var annotations = [MKPointAnnotation]()
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = ParseClient.sharedInstance().userID!
        
        ParseClient.sharedInstance().getStudentLocation(userID, {(studentLocation, error) in
            if let studentLocation = studentLocation {
                self.studentLocation = studentLocation
            }
        })
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
            let lat = CLLocationDegrees(dictionary.latitude )
            let long = CLLocationDegrees(dictionary.longitude )
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
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
