//
//  GeneralViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 23..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //show Alert
    func showAlert(_ title: String?, message: String, handler: @escaping() -> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) -> Void in
            handler()
        })
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //continue alert
    func askToContinueAlert(_ title: String?, message: String, _ completionHandler: @escaping (_ : Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        // Overwrite Button Action to pass true to completionHandler if pressed by user
        let overwriteAction = UIAlertAction(title: "Overwrite", style: .default, handler: { (action) -> Void in
            completionHandler(true)
        })
        // Cancel Button Action handlder to pass false to completion handler
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            completionHandler(false)
        })
        //Add Overwrite and Cancel button to dialog message
        alert.addAction(overwriteAction)
        alert.addAction(cancelAction)
        // Present dialog message to user
        self.present(alert, animated: true, completion: nil)
    }
    
    // Activity indicator
    // Get New Activity Indicator and Start Animating
    func startActivityIndicator(for controller: UIViewController, _ activityIndicator: UIActivityIndicatorView, _ style: UIActivityIndicatorViewStyle) {
        activityIndicator.center = controller.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = style
        
        if style == .whiteLarge || style == .white {
            for subview in controller.view.subviews {
                subview.alpha = 0.6
            }
            controller.view.backgroundColor = UIColor.darkGray
        }
        controller.view.addSubview(activityIndicator)
        activityIndicator.alpha = 1.0
        activityIndicator.startAnimating()
    }
    
    // Stop Activity Indicator
    func stopActivityIndicator(for controller: UIViewController, _ activityIndicator: UIActivityIndicatorView) {
        guard activityIndicator.isAnimating else {
            return
        }
        if (activityIndicator.activityIndicatorViewStyle == .whiteLarge || activityIndicator.activityIndicatorViewStyle == .white) {
            controller.view.backgroundColor = UIColor.white
            for subview in controller.view.subviews {
                subview.alpha = 1.0
            }
        }
        activityIndicator.stopAnimating()
    }
    
}
