//
//  InfoViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 26..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController : UIViewController {
    
    var student: ParseStudent?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        locationTextField.delegate = self as UITextFieldDelegate
        websiteTextField.delegate = self as UITextFieldDelegate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapViewSegue" {
            let controller = segue.destination as! LocationViewController
            controller.userLocationString = locationTextField.text
            controller.mediaURL = websiteTextField.text
            
            if let student = student{
                controller.objectID = student.objectID
                print("ObjectID being passed to LocationViewController\(student.objectID!)")
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "mapViewSegue" {
            guard let locationString = locationTextField.text, !locationString.isEmpty  else {
                showAlert("Location Not Found", message: "Must Enter a Location.")
                return false
            }
            guard let url = websiteTextField.text, !url.isEmpty else {
                showAlert("Location Not Found", message: "Must Enter a Website.")
                return false
            }
            if (!url.contains("https://")) {
                showAlert("Location Not Found", message: "Website must include \"https://\"")
                return false
            }
        }
        return true
    }
}

extension InfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var y = 0
        if textField == websiteTextField {
            y = 120
        } else if textField == locationTextField {
            y = 60
          }
        
        if UIDevice.current.orientation.isLandscape {
            scrollView.setContentOffset(CGPoint(x:0,y:y), animated: true)
        }
      }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if UIDevice.current.orientation.isLandscape {
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
    }
    
}