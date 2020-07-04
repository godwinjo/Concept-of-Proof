//
//  ItemViewModel.swift
//  Concept of Proof
//
//  Created by Godwin on 03/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation
import UIKit

class ItemViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var item: Item?
    
    // MARK: Get Items
    func getItems(completion: @escaping (_ status: Bool, _ pageTitle: String?, _ errorMessage: String?) -> Void) {
        APIManager.getItemsList { (status, item, errorMessage) in
            self.resultValidate(status: status, item: item, errorMessage: errorMessage) { (status, title, errorMessage) in
                completion(status, title, errorMessage)
            }
        }
    }
    
    // MARK: Result Validation
    func resultValidate(status: Bool, item: Item?, errorMessage: String?, completion: @escaping (_ status: Bool, _ pageTitle: String?, _ errorMessage: String?) -> Void) {
        if status == true {
        if let itm = item {
            self.item = itm
            completion(true, self.item?.title, nil)
        }
        } else {
            completion(false, nil, errorMessage)
        }
    }
    
    // MARK: TableView DataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.getNumberOfRows(itemDetails: self.item?.rows)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let itemDeatils = self.item?.rows?[indexPath.row] {
                return self.setCells(tableView: tableView, indexPath: indexPath, itemDetails: itemDeatils)
            }
            return UITableViewCell()
        }
        
        // MARK: Set Cells
        func setCells(tableView: UITableView, indexPath: IndexPath, itemDetails: ItemDetails) -> UITableViewCell {
            let cellIdentifier = ItemDetailsTableViewCell.identifier
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemDetailsTableViewCell {
                cell.selectionStyle = .none
                cell.itemDetails = itemDetails
                cell.initControlls()
                return cell
            }
            return UITableViewCell()
        }
        
        // MARK: getNumberOfRows
        func getNumberOfRows(itemDetails: [ItemDetails]?) -> Int {
            if let itmDetails = itemDetails {
                return itmDetails.count
            }
            return 0
        }
        
        // MARK: TableViewDelegate
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
}
