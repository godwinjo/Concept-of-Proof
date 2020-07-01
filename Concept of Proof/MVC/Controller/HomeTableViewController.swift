//
//  HomeTableViewController.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var item : Item?
    var pageTitle : String = "" {
        didSet {
            setPageTitle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.getItems()
    }
    
//    MARK:- Set Page Title
    func setPageTitle()  {
        self.title = pageTitle
    }

//    MARK:- Get Items
    func getItems()  {
        APIManager.getItemsList { (status, result, error) in
            if let dict = result {
                self.item = Item(dict: dict)
            }
            DispatchQueue.main.async {
                self.pageTitle = self.item?.itemTitle ?? ""
                self.tableView.reloadData()
            }
            
        }
    }
    
//    MARK:- Configure TableView
    func configureTableView()  {
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
    }
    
    
}
extension HomeTableViewController {
//    MARK:- TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if item != nil && item?.itemDetails != nil {
            return item!.itemDetails!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier, for: indexPath) as! ItemDetailsTableViewCell
        cell.addItemsToView()
        cell.itemDetails = item?.itemDetails![indexPath.row]
        return cell
    }
    
//    MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}