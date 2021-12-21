//
//  DataModel.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Mac on 17/05/1443 AH.
//

import Foundation


struct TaskResult: Codable {
    let id: Int
    let objective, createdAt: String
    
    
    enum CodingKeys: String, CodingKey {
                case id
                case objective
                case createdAt = "created_at"
                
            }
    
}
