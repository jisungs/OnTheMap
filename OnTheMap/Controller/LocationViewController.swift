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
        static let PutSuccess = "Your Location Updated Successfully!"
        static let PostSuccess = "Your Location Added Successfully!"
        static let PutError = "Error - Location Update Failed."
        static let PostError = "Error - Didn't Save Location."
        
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: BorderedButton!
    
    @IBAction func finishPressed(_ sender: Any) {
        
        finishButton.isEnabled = false
        
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        
        UdacityClient.sharedInstance().getUserInfo{(student, error) in
            
            if let error = error {
                self.updateUI("Error user info:\(error)")
                self.showAlert("The location was not found", message: "Location Error")
               } else if let student = student {
                let studentDict: [String:AnyObject] = [
                    "uniqueKey": student.userID as AnyObject,
                    "firstName": student.firstName as AnyObject,
                    "lastName": student.lastName as AnyObject,
                    "mapString": self.userLocationString as AnyObject,
                    "mediaURL": self.mediaURL as AnyObject,
                    "latitude": self.lat as AnyObject,
                    "longitude": self.long as AnyObject ]
                if let objectID = self.objectID, objectID.isEmpty{
                    self.putToExistingLocation(objectID: objectID, dictionary: studentDict)
                } else {
                    self.postNewLocation(dictionary: studentDict)
                }
            }
        }
     }
    
    func putToExistingLocation(objectID: String, dictionary:[String:AnyObject]){
        ParseClient.sharedInstance().putToStudentLocation(objectID, dictionary,{(success, error) in
            if success{
                self.message = Message.PutSuccess
            } else {
                self.message = Message.PutError
            }
            self.updateUI(self.message!)
        })
    }
    
    func postNewLocation(dictionary:[String:AnyObject]){
        ParseClient.sharedInstance().postToStudentLocation(dictionary, {(success, error) in
            if success{
                self.message = Message.PutSuccess
            } else {
                self.message = Message.PutError
            }
            self.updateUI(self.message!)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        finishButton.isHidden = false
        lookupGeocoding()
        reverseGeocoding()
    }
    
    func updateUI(_ message:String){
        performUIUpdatesOnMain {
            self.stopActivityIndicator(for: self, self.activityIndicator)
            self.showAlert(nil, message: self.message!, handler:{self.startOver()
                self.startOver()
            })
        }
    }
    
    func startOver(){
        self.navigationController?.dismiss(animated: true, completion: nil)
        finishButton.isEnabled = true
    }
    
    func lookupGeocoding(){
        if geocoder == nil {
            geocoder = CLGeocoder()
          }
       }
    
    
    func reverseGeocoding(){
        
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        geocoder?.geocodeAddressString(userLocationString!, completionHandler: {(placemarks, error) in
            
            guard error == nil else {
                /*The location was not found, present a dialog informing the user about the error*/
                self.showAlert("The location was not found", message: "Error")
              return  print("The location was not found.")
            }
            
            let coordinates = placemarks!.first!.location!.coordinate
            let placemark = placemarks?.first
            let city = placemark?.locality
            let state = placemark?.administrativeArea
            let zip = placemark?.postalCode
            let country = placemark?.isoCountryCode
            
            var address: String? = ""
            var comma: String = ","
            let space: String = " "
            
            func appendAddress(_ optionalString: String?, _ seprator: String) {
                if let optionalString = optionalString {
                    address?.append("\(optionalString)\(seprator)")
                }
            }
            
            appendAddress(city, comma)
            appendAddress(state, space)
            appendAddress(zip, comma )
            appendAddress(country, "")
            
            // Pass values to generate MapView
            self.renderMapWithPinView(latitude: coordinates.latitude, longitude: coordinates.longitude, title: self.userLocationString!)
        })
        stopActivityIndicator(for: self, activityIndicator)
        
    }
    
    func renderMapWithPinView(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let regionRadius: CLLocationDistance  = 250
        
        annotation.coordinate = coordinate
        annotation.title = title
        
        performUIUpdatesOnMain {
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, regionRadius, regionRadius), animated: true)
        }
    }
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation)-> MKAnnotationView? {
        
        let reuseID = "pin"
        var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinAnnotationView == nil{
            pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinAnnotationView!.canShowCallout = true
            pinAnnotationView!.pinTintColor = .red
        } else {
            pinAnnotationView?.annotation = annotation
        }
        return pinAnnotationView
    }
}
