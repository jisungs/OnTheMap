//
//  LocationViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 28..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class LocationViewController: UIViewController{
    
    var geocoder: CLGeocoder?
    var objectID: String?
    
    var userLocationString: String?
    var mediaURL: String?
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    var message: String?
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    struct Message{
        
    }
    
    
    @IBOutlet weak var mapview: MKMapView!
    
}
