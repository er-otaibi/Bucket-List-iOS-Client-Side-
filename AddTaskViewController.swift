//
//  AddTaskViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 17/05/1443 AH.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var objectiveTextField: UITextField!
    
    var task: [TaskResult]?
    
    var objectiveEdit: String?
    
    var delegate: TaskDelegate?
    
    var indexPath: IndexPath?
    
    var currentTask: TaskResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        objectiveTextField.text = objectiveEdit
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
           guard let objectivepost = objectiveTextField.text else { return }
           delegate?.taskSaved(by: self, with : objectivepost ,at :indexPath)
           dismiss(animated: true, completion: nil)
       
    }
    
}

