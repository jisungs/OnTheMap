//
//  ListViewController.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 24..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    var firstName = "Please enter your First Name"
    var lastName = "Please enter your Last Name"
    
    
    @IBOutlet weak var studentsTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentsTabelView.delegate = self
        studentsTabelView.dataSource = self
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentStorage.shareInstance.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "LocationCell"
        let student = StudentStorage.shareInstance.students[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as
        UITableViewCell? 
        
        if let studentFirstName = student.firstName{
            firstName = studentFirstName
        }
        if let studentLastName = student.lastName{
            lastName = studentLastName
        }
        cell?.textLabel?.text = "\(firstName) \(lastName)"
        cell?.detailTextLabel?.text = student.mediaURL
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = StudentStorage.shareInstance.students[(indexPath as NSIndexPath).row]
        
        if let urlString = student.mediaURL{
            if let url = URL(string: urlString){
                
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }else{
                    notifyUser(nil, message:"Invalid Link")
                }
            }
        }
    }
    
    func refreshTableView(){
        if let studentsTableView = studentsTabelView {
            studentsTabelView.reloadData()
        }
    }
}

extension ListViewController{
    func notifyUser(_ title:String?, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title:"Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


