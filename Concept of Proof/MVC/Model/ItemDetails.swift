//
//  ItemDetails.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit

class Item: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var itemTitle: String?
    var itemDetails: [ItemDetails]?
    
    // MARK: initialize values
    func initValues(dict: NSDictionary) {
        self.itemTitle = dict["title"] as? String
        if let rows = dict["rows"] as? NSArray {
            itemDetails = [ItemDetails]()
            for row in rows {
                let itemDetail = ItemDetails(dict: row as? NSDictionary)
                itemDetails?.append(itemDetail)
            }
        }
    }
    
    // MARK: Get Items
    func getItems(completion: @escaping (_ status: Bool, _ pageTitle: String?, _ error: Error?) -> Void) {
        APIManager.getItemsList { (status, result, error) in
            self.resultValidate(status: status, dict: result, error: error) { (status, title, error) in
                completion(status, title, error)
            }
        }
    }
    
    // MARK: Result Validation
    func resultValidate(status: Bool, dict: NSDictionary?, error: Error?, completion: @escaping (_ status: Bool, _ pageTitle: String?, _ error: Error?) -> Void) {
        if status == true {
        if let dict = dict {
            self.initValues(dict: dict)
            completion(true, self.itemTitle ?? "", nil)
        }
        } else {
            if error != nil {
                completion(false, nil, error)
                return
            }
            completion(false, nil, error)
        }
    }
    
// MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.getNumberOfRows(itemDetails: itemDetails)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.setCells(tableView: tableView, indexPath: indexPath, itemDetails: itemDetails![indexPath.row])
    }
    
    // MARK: Set Cells
    func setCells(tableView: UITableView, indexPath: IndexPath, itemDetails: ItemDetails) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier, for: indexPath) as? ItemDetailsTableViewCell
        cell?.selectionStyle = .none
        cell?.itemDetails = itemDetails
        cell?.initControlls()
        return cell!
    }
    
    // MARK: getNumberOfRows
    func getNumberOfRows(itemDetails: [ItemDetails]?) -> Int {
        if itemDetails != nil {
            return itemDetails!.count
        }
        return 0
    }
    
    // MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

// MARK: Item Details Model
struct ItemDetails {
    
    var itemTitle: String?
    var itemDescription: String?
    var itemImage: String?
    
    init(dict: NSDictionary?) {
        self.itemTitle = dict?["title"] as? String
        self.itemDescription = dict?["description"] as? String
        self.itemImage = dict?["imageHref"] as? String
    }

}
