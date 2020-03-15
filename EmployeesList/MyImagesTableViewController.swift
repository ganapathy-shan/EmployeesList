//
//  MyImagesTableViewController.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 03/02/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var emailID: UILabel!
}

class MyImagesTableViewController: UITableViewController {
    var employeesData : EmployeesData?
    var allEmployees : [EmployeesData] = [EmployeesData]()
    
    let baseUrl = URL(string: "https://reqres.in/api/users")!
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiManager = APIManager(baseURL: baseUrl , endpointURL: nil)
        apiManager.getEmployeeDetails { (data, response, error) in
            guard let data = data else { return }
            let jsonParser = EmployeeJSONParser()
            let numberOfPages = jsonParser.gatNumberOfPages(data: data)
            for i in 1...numberOfPages
            {
                let endPoint = "page=" + String(i)
                let baseUrl = URL(string: "https://reqres.in/api/users")!
                let employeesDownloadAPIManager = APIManager(baseURL: baseUrl , endpointURL: endPoint)
                employeesDownloadAPIManager.getEmployeeDetails(completionHandler: { (data, response, error) in
                    guard let data = data else { return }
                    if let employeesData = jsonParser.gatEmployeeData(data: data)
                    {
                        self.allEmployees.append(employeesData)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return employeesData?.totalPages ?? 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employeesData?.entriesPerPage ?? 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  : EmployeeCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! EmployeeCell
        if(self.allEmployees.count >= self.tableView.numberOfSections)
        {
            let employee = self.allEmployees[indexPath.section].employees?[indexPath.row]
            cell.firstName.text = employee?.firstName
            cell.lastName.text = employee?.lastName
            cell.emailID.text = employee?.emailId
        }

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "EmployeeDetailSegue", sender: self)
//    }
        

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        guard let employee = self.allEmployees[indexPath.section].employees?[indexPath.row] else { return }
        let employeeVC = segue.destination as! EmployeeViewController
        employeeVC.employee = employee
    }
    

}
