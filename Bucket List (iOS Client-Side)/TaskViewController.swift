//
//  ViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 17/05/1443 AH.
//

import UIKit

class TaskViewController: UITableViewController , TaskDelegate {
    
    
    var task: [TaskResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.gatData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ItemSegue" , sender: sender)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let navigationController = segue.destination as! UINavigationController
        let destination = navigationController.topViewController as! AddTaskViewController
        destination.delegate = self
        
        if let sender = sender as? IndexPath {
            
            destination.objectiveEdit = task?[sender.row].objective
            destination.indexPath = sender
        }
       
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let item = task?[indexPath.row].id  else { return }
        
        TaskModel.deleteTaskWithObjective(id: item, completionHandler:  {
            // see: Swift closure expression syntax
            data, response, error in
            
            print("in here DELETE")
            print(data ?? "no data DELETE")
           

                DispatchQueue.main.async {
                    self.task = self.gatData()
                    self.tableView.reloadData()
                }
                
            
        })
        tableView.dataSource = self
    }
    
    func taskSaved(by controller: AddTaskViewController, with objective: String, at indexPth: IndexPath?) {
       
        if let editIndexPath = indexPth {
            
            guard var item = task?[editIndexPath.row] else {return}
            item.objective = objective
            
            TaskModel.updateTaskWithObjective(id: item.id , objective: objective , completionHandler:  {
            
                            data, response, error in
                            print("in here Edit ")
        
                            print(data ?? "no data Edit")
                guard let myData = data else { return }
                do {
     
                    let realData = try JSONDecoder().decode(TaskResult.self, from: myData)
                    DispatchQueue.main.async {
                        self.task?[editIndexPath.row] = realData
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
          
                        })
                }else{

                    postData(objective: objective)
                    
                }
        tableView.dataSource = self
    }
    
    func postData(objective: String) {
        
        TaskModel.addTaskWithObjective(objective: objective , completionHandler:  {
            
            // see: Swift closure expression syntax
            data, response, error in
            print("in here Post ")
            
            // see: Swift nil coalescing operator (double questionmark)
            print(data ?? "no data Post") // the "no data" is a default value to use if data is nil
            
            guard let myData = data else { return }
            do {
                
                let realData = try JSONDecoder().decode(TaskResult.self, from: myData)
                print(realData)
                DispatchQueue.main.async {
                    self.task = self.gatData()
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        })
        tableView.dataSource = self
    }
    
    
    func gatData() -> [TaskResult] {
        var jsonResult = [TaskResult]()
    
        TaskModel.getAllTasks(completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            print("in here get")
            
            // see: Swift nil coalescing operator (double questionmark)
            print(data ?? "no data get") // the "no data" is a default value to use if data is nil
            
            guard let myData = data else { return }
            do {
                
                let decoder = JSONDecoder()
                jsonResult = try decoder.decode([TaskResult].self, from: myData)
                
                DispatchQueue.main.async {
                    self.task = jsonResult
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        })
     
    
        tableView.dataSource = self
        
        return jsonResult
    }
    
}

