//
//  LoginController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 15..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController, UITextFieldDelegate{
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Outlet
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var fbLoginButton: BorderedButton!
    
    // Action
    

    @IBAction func loginPressed(_ sender: Any) {
     
    }
    
}
