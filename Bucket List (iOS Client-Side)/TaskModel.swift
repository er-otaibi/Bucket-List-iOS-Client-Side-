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
}
