//
//  TaskModel.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 17/05/1443 AH.
//

import Foundation

class TaskModel {
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
       
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/?format=json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
        
    }
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/?format=json") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
    static func deleteTaskWithObjective(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to DELETE
                request.httpMethod = "DELETE"
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
    static func updateTaskWithObjective(id: Int,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
        print(objective)
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                
                // Set the method to PUT
                request.httpMethod = "PUT"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "{\"objective\":\"\(objective)\"}"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
}
