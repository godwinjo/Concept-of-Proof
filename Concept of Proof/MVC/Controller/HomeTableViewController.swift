//
//  HomeTableViewController.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var item: Item?
    var pageTitle: String = "" {
        didSet {
            setPageTitle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getItems()
        
    }
    
    // MARK: Get Items
    func getItems() {
        item = Item()
        self.tableView.dataSource = item
        self.tableView.delegate = item
        item?.getItems { (status, pageTitle, error) in
            if status == true {
                if let title = pageTitle {
                    DispatchQueue.main.async {
                        self.pageTitle = title
                        self.tableView.reloadData()
                    }
                }
            } else {
                self.showAlert(title: "Alert", message: error!.localizedDescription)
            }
        }
    }
    
// MARK: Set Page Title
    func setPageTitle() {
        self.title = pageTitle
    }
        
// MARK: Configure TableView
    func configureTableView() {
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
    }
    
}

extension HomeTableViewController {
// MARK: Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
