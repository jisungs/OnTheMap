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
    
    // Actions
    
    @IBAction func refreshPressed(_ sender: Any) {
        refreshData()
    }
    
    @IBAction func addLocatoinPressed(_ sender: Any) {
        if let studentLocation = studentLocation{
        
            askToContinueAlert(nil, message: ",User, \"\(studentLocation.firstName!) \(studentLocation.lastName!)\"Would you like to Overwrite Their Location?", { (overwrite) in
                if overwrite {
                    self.performSegue(withIdentifier: "infoSegue", sender: sender)
                }
            })
        
        }else{
            performSegue(withIdentifier:"infoSegue", sender: sender)
        }
    }
    // logout message show
    func completeLogout(){
        UdacityClient.sharedInstance().sessionLogout{(success, erroString) in
            performUIUpdatesOnMain {
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showAlert("LogOut Fail", message: "\(erroString!)")
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
    
    //refresh data func
    func refreshData(){
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        
        let mapViewController = self.viewControllers?[0] as! MapViewController
        let listViewController = self.viewControllers?[1] as! ListViewController
        
        ParseClient.sharedInstance().getStudentLocations{
            (students, error) in
            if let students = students{
                listViewController.students = students
                
                performUIUpdatesOnMain {
                    mapViewController.addAnnotationsToMapView(locations: students)
                    listViewController.refreshTableView()
                    
                    self.stopActivityIndicator(for: self, self.activityIndicator)
                     }
            } else {
                performUIUpdatesOnMain {
                    self.showAlert("NO Data", message:(error?.localizedDescription)!)
                    self.stopActivityIndicator(for: self, self.activityIndicator)
                }
            }
        }
    }
}

extension StudentsTabBarController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue"{
            if let studentLocation = studentLocation{
                let navController = segue.destination as! UINavigationController
                let controller = navController.viewControllers.first as! InfoViewController
                controller.student = studentLocation
            }
        }
    }
}





