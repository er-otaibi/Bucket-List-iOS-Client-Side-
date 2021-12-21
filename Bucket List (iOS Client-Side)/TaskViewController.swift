//
//  ViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 17/05/1443 AH.
//

import UIKit

class TaskViewController: UITableViewController {

    var task: [TaskResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gatData()
       
    }
    
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return task?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell" , for: indexPath)
       
        cell.textLabel?.text = task?[indexPath.row].objective
     
        return cell
        
    }
    
    func gatData() {
      
        TaskModel.getAllTasks(completionHandler: {
                    // see: Swift closure expression syntax
                    data, response, error in
                    print("in here")
                    
                    // see: Swift nil coalescing operator (double questionmark)
                    print(data ?? "no data") // the "no data" is a default value to use if data is nil
                    
                    guard let myData = data else { return }
                do {
                
                                    let decoder = JSONDecoder()
                                    let jsonResult = try decoder.decode([TaskResult].self, from: myData)
                                    self.task = jsonResult
                                   // print(jsonResult)
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                } catch {
                    print(error)
                }
            })
            // execute the task and then wait for the response
            // to run the completion handler. This is async!
          tableView.dataSource = self
        }

}

