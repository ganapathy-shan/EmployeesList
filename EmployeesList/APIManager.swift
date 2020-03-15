//
//  APIManager.swift
//  EmployeesList
//
//  Created by Shanmuganathan on 28/02/20.
//  Copyright © 2020 Shanmuganathan. All rights reserved.
//

import UIKit

//URL : https://reqres.in/api/users?page=1
class APIManager: NSObject {
    
    var baseURL : URL
    var endpointURL : String?
    
    init(baseURL : URL?, endpointURL : String?) {
        self.baseURL = baseURL ?? URL(string: "https://reqres.in/api/users")!
        self.endpointURL = endpointURL
    }
    
    func getEmployeeDetails(completionHandler : @escaping CompletionBlock)
    {
        let networkService = NetworkService(session: URLSession.shared) { (data, response, error) in
        completionHandler(data, response, error)
        }
        var urlToRequest = self.baseURL
        if (self.endpointURL != nil)
        {
            var urlComponents = URLComponents(url: urlToRequest, resolvingAgainstBaseURL: true)!
            urlComponents.query = self.endpointURL
            urlToRequest = urlComponents.url!
        }
        let task = networkService.dataTaskWithURL(with: urlToRequest)
        //let task = networkService.dataTaskWithURL(with: URL(string: "https://reqres.in/api/users?page=1"))
        task?.resume()
    }
    
    func getImage(imageURL : URL?, imageDownloadedCallback : @escaping (UIImage?) -> Void)
    {
        guard let imageURL = imageURL else { return }
        let networkService = NetworkService(session: URLSession.shared) { (data, response, error) in
            guard let data = data else { return }
            if let image = UIImage(data: data)
            {
                imageDownloadedCallback(image)
            }
            else
            {
                imageDownloadedCallback(nil)
            }
        }
        let task = networkService.dataTaskWithURL(with: imageURL)
        task?.resume()
    }
}
