//
//  EmployeeJSONParser.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 04/03/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

class EmployeeJSONParser: NSObject {
    
    var data : Data?
    
    func gatNumberOfPages(data : Data) -> Int {
        var numberOfPages : Int = 1
        do
        {
            let decoder = JSONDecoder()
            let employeesData = try decoder.decode(EmployeesData.self, from: data)
            numberOfPages = employeesData.totalPages
        }
        catch
        {
            print("Unexpected error: \(error)")
        }
        return numberOfPages
    }
    
    func gatEmployeeData(data : Data) -> EmployeesData? {
        var employeesData : EmployeesData?
        do
        {
            let decoder = JSONDecoder()
            employeesData = try decoder.decode(EmployeesData.self, from: data)
        }
        catch
        {
            print("Unexpected error: \(error)")
        }
        return employeesData
    }
}
