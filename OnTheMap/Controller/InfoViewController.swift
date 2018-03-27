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
        locationTextField.delegate = self as! UITextFieldDelegate
        websiteTextField.delegate = self as! UITextFieldDelegate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapViewSegue" {
            let controller = segue.destination as! LocationViewController
            
        }
    }
    
    
}
