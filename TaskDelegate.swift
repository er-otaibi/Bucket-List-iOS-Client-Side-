//
//  TaskDelegate.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 18/05/1443 AH.
//

import Foundation


protocol TaskDelegate : AnyObject {
    
    func taskSaved(by controller: AddTaskViewController, with objective:String , at indexPth : IndexPath?)
    
}
