//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 21..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
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

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // show hide keyboard
    func keyboardWillsHow(_ notification:Notification){
        if !keyboardOnScreen {
        }
    }
    
    func keyboardHeight(_ notification:Notification)->CGFloat{
        let userInfo = (notification as Notification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}
