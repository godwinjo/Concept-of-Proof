//
//  ItemDetails.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation

// MARK: Item Model
struct Item: Codable {
    
    var title: String?
    var rows: [ItemDetails]?
    
}

// MARK: Item Details Model
struct ItemDetails: Codable {
    
    var title: String?
    var description: String?
    var imageHref: String?

    // MARK: Values check
    func valuesCheck() -> Bool {
        if self.title == nil && self.title == nil && self.title == nil {
            return false
        }
        return true
    }

}
