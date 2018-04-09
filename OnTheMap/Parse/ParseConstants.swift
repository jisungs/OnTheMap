//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 18..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation

extension ParseClient {
    
    struct Constants {
        
        //API Keys
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // URLS
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        
    }
    
    struct Methods {
        
        //Student Location
        static let StudentLocation = "/StudentLocation"
        static let Put = "/StudentLocation/<objectId>"
        
    }
    
    //URL Keys
    struct URLKeys {
        static let UniqueKey = "uniqueKey"
        static let ObjectID = "objectId"
    }
    
    //Parameter Keys
    struct ParameterKeys {
        static let ApiKey = "X-Parse-REST-API-Key"
        static let ApplicationID = "X-Parse-Application-Id"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Where = "where"
        static let Query = "query"
        static let Limit = "limit"
        static let Order = "order"
    }
    
    //JSON Body Keys
    struct JSONBodyKeys {
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    //JSON Response Keys
    struct JSONResponseKeys {
        
        //General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        //UniqueKey
        static let UniqueKey = "uniqueKey"
        
        //Students
        static let StudentMediaURL = "mediaURL"
        static let StudentObjectId = "objectId"
        static let StudentMapString = "mapString"
        static let StudentFirstName = "firstName"
        static let StudentLastName = "lastName"
        static let StudentUniqueKey = "uniqueKey"
        static let StudentLatitude = "latitude"
        static let StudentLongitude = "longitude"
        static let StudentResults = "results"
        static let StudentUpdatedAt = "updatedAt"
        
    }
    
}
