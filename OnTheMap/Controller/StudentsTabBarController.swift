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
    
    //MARK: - Actions
    
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
    
    @IBAction func logout(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) -> Void in
            
            self.completeLogout()
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: -  logout message show
    func completeLogout(){
        //MARK: - ADD ActivityIdicator
        startActivityIndicator(for: self, activityIndicator, .gray)
        
        UdacityClient.sharedInstance().sessionLogout{(success, erroString) in
            performUIUpdatesOnMain {
                if success{
                    self.dismiss(animated: true, completion: nil)
                    self.stopActivityIndicator(for: self, self.activityIndicator)
                    
                }else{
                    self.showAlert("LogOut Fail", message: "\(erroString!)")
                 }
               }
            }
         }
    
    //MARK: - display error
    func displayError(_ errorString:String?){
        if let errorString = errorString {
            print(errorString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* let userID = ParseClient.sharedInstance().userID!
        
        ParseClient.sharedInstance().getStudentLocation(userID, {(studentLocation, error) in
            if let studentLocation = studentLocation {
                self.studentLocation = studentLocation
            }
        })*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    

    
    //MARK:- refresh data func
    func refreshData(){
        startActivityIndicator(for: self, activityIndicator, .whiteLarge)
        
        let mapViewController = self.viewControllers?[0] as! MapViewController
        let listViewController = self.viewControllers?[1] as! ListViewController
        let selectedViewController = self.selectedViewController
        
        if selectedViewController is ListViewController{
            ParseClient.sharedInstance().getStudentLocation("studentLocation"){
                (students, error) in
                if let students = students {
                    listViewController.students = [students]
                    
                    performUIUpdatesOnMain {
                        mapViewController.addAnnotationsToMapView(locations: [students])
                        listViewController.refreshTableView()
                        
                        self.stopActivityIndicator(for: self, self.activityIndicator)
                    }
                } else if error != nil {
                    self.showAlert("Location error", message: "Could not find location")
                }
                }
        }else if selectedViewController is MapViewController {
            ParseClient.sharedInstance().getStudentLocations{(students, error) in
                if let students = students{
                    listViewController.students = students
                    
                    performUIUpdatesOnMain {
                        mapViewController.addAnnotationsToMapView(locations: students)
                        listViewController.refreshTableView()
                        
                        self.stopActivityIndicator(for: self, self.activityIndicator)
                    }
                }else if error != nil{
                    self.showAlert("Location error", message: "Could not find location")
                }
        }
    }
}
    
    
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






