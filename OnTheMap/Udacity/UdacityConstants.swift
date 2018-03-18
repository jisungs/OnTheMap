//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 19..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    //sturct about URLS

    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        static let SignupPath = "https://www.udacity.com/account/auth#!/signup"
    }
    // Methods it's about fucntion in class
    struct Methods {
        static let Session = "/session"
        static let Get = "/users/{id}"
    }
    
    // URL Keys definition of id
    struct URLKeys {
        static let UserID = "id"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let SessionID = "session_id"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Username = "username"
        static let Password = "password"
        static let AccessToken = "access_token"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let Account = "account"
        static let Session = "session"
        static let SessionID = "id"
        
        static let UniqueKey = "key"
        static let FirstName = "first_name"
        static let LastName = "last_name"
        static let UserResult = "user"
        
    }
}
