//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 21..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    //variable
    var keyboardOnScreen = false
    
    //Outlet
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fbLoginButton: UIButton!
    
    //Action
    
    //Udacity Login process
    @IBAction func loginPressed(_ sender: Any) {
    }
    
    //FaceBook Login Process
    
    @IBAction func fbLoginPressed(_ sender: Any) {
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    

    
}
