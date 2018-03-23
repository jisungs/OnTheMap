//
//  StudentsTabBarController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 24..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class StudentsTabBarController: UITabBarController {
 
    var studentLocation: ParseStudent?
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    // logout message show
    func completeLogout(){
        UdacityClient.sharedInstance().sessionLogout{(success, erroString) in
            performUIUpdatesOnMain {
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showAlert("LogOut Fail", message: "\(erroString)")
                 }
               }
            }
         }
    
    //display error
    func displayError(_ errorString:String?){
        if let errorString = errorString {
            print(errorString)
        }
    }
    
    func refreshData(){
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        
        let mapViewController = self.viewControllers?[0] as! MapViewController
        let listViewController = self.viewControllers?[1] as! ListViewController
        
        
    }
    
}
