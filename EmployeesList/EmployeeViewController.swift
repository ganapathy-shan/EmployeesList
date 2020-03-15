//
//  EmployeeViewController.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 04/03/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet var employeeImageView: UIImageView!
    @IBOutlet var employeeName: UILabel!
    @IBOutlet var employeeID: UILabel!
    @IBOutlet var employeeEmailID: UILabel!
    
    var employee : Employee? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let employeeID = employee?.employeeId,
            let firstName = employee?.firstName,
            let lastName = employee?.lastName,
            let emailID = employee?.emailId,
            let imageURL = employee?.imageURL
        {
            self.employeeID.text = String(10000+employeeID)
            self.employeeName.text  = firstName + " " + lastName
            self.employeeEmailID.text = emailID
            self.navigationItem.title = firstName + " " + lastName
            let apiManager = APIManager(baseURL: nil, endpointURL: nil)
            apiManager.getImage(imageURL: URL(string:imageURL)!) { (image) in
                DispatchQueue.main.async {
                    self.employeeImageView.image = image
                }
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
