//
//  AnnotationPin.swift
//  OnTheMap
//
//  Created by The book on 2018. 5. 5..
//  Copyright © 2018년 The book. All rights reserved.
//

import MapKit

class AnnotatinoPin: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
    
}
