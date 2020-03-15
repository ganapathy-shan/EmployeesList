//
//  Employee.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 02/03/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

struct EmployeesData: Codable
{
    var pageNumber : Int
    var entriesPerPage : Int
    var totalEntries : Int
    var totalPages : Int
    var employees : [Employee]?
    
    enum CodingKeys: String, CodingKey
    {
        case pageNumber = "page"
        case entriesPerPage = "per_page"
        case totalEntries = "total"
        case totalPages = "total_pages"
        case employees = "data"
    }
}

struct Employee: Codable {
    
    var employeeId : UInt32
    var emailId : String?
    var firstName : String? 
    var lastName : String?
    var imageURL : String?
    
    enum CodingKeys: String, CodingKey
    {
        case employeeId = "id"
        case emailId = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "avatar"
    }
}
