//
//  ItemDetails.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation

// MARK: Item Model
struct Item {
    
    var itemTitle: String?
    var itemDetails: [ItemDetails]?
    
    // MARK: initialize values
    init(dict: [String: Any]) {
        self.itemTitle = dict["title"] as? String
        if let rows = dict["rows"] as? [[String: Any]] {
            itemDetails = [ItemDetails]()
            for row in rows {
                let itemDetail = ItemDetails(dict: row)
                if itemDetail.valuesCheck() {
                    itemDetails?.append(itemDetail)
                }
            }
        }
    }
}

// MARK: Item Details Model
struct ItemDetails {
    
    var itemTitle: String?
    var itemDescription: String?
    var itemImage: String?
    
    // MARK: initialize values
    init(dict: [String: Any]) {
        self.itemTitle = dict["title"] as? String
        self.itemDescription = dict["description"] as? String
        self.itemImage = dict["imageHref"] as? String
    }
    
    // MARK: Values check
    func valuesCheck() -> Bool {
        if self.itemTitle == nil && self.itemDescription == nil && self.itemImage == nil {
            return false
        }
        return true
    }

}
