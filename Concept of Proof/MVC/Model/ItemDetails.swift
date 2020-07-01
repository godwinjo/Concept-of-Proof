//
//  ItemDetails.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit


struct Item  {
    
    var itemTitle :   String?
    var itemDetails : [ItemDetails]?
    
    init(dict:NSDictionary) {
        self.itemTitle = dict["title"] as? String
        if let rows = dict["rows"] as? NSArray {
            itemDetails = [ItemDetails]()
            for row in rows {
                let itemDetail = ItemDetails(dict: row as! NSDictionary)
                itemDetails?.append(itemDetail)
            }
        }
    }

}

struct ItemDetails {
    
    var itemTitle :        String?
    var itemDescription : String?
    var itemImage :       String?
    
    init(dict:NSDictionary) {
        self.itemTitle = dict["title"] as? String
        self.itemDescription = dict["description"] as? String
        self.itemImage = dict["imageHref"] as? String
    }

}
