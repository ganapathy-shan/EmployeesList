//
//  NetworkService.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 02/03/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

typealias CompletionBlock = (Data?, URLResponse?, Error?) -> Void

class NetworkService: NSObject
{
    let session : URLSession
    let completionBlock : CompletionBlock
    
    
    init(session : URLSession, completionBlock : @escaping CompletionBlock )
    {
        self.session = session
        self.completionBlock = completionBlock
    }
    
    
    func dataTaskWithURL(with url: URL) -> URLSessionDataTask?
    {
        return self.dataTaskWithURL(with: URLRequest(url: url))
    }
    
    func dataTaskWithURL(with request: URLRequest) -> URLSessionDataTask
    {
        let task = self.session.dataTask(with: request) { (data, response, error) in
            if let data = data
            {
                self.completionBlock(data, response, error)
            }
        }
        return task
    }

}
