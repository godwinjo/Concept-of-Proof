//
//  HomeTableViewController.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var itemViewModel: ItemViewModel?
    var refreshcontrl = UIRefreshControl()
    var pageTitle: String = "" {
        didSet {
            setPageTitle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setDataSourceandDelegate()
        
    }
    
    // MARK: Get Items
    func setDataSourceandDelegate() {
        itemViewModel = ItemViewModel()
        self.tableView.dataSource = itemViewModel
        self.tableView.delegate = itemViewModel
        itemViewModel?.getItems { (status, pageTitle, errorMessage) in
            self.refreshcontrl.endRefreshing()
            if status == true {
                if let title = pageTitle {
                    DispatchQueue.main.async {
                        self.pageTitle = title
                        self.tableView.reloadData()
                    }
                }
            } else {
                if let errorMsg = errorMessage {
                    self.showAlert(title: "Alert", message: errorMsg)
                }
            }
        }
    }
    
// MARK: Set Page Title
    func setPageTitle() {
        self.title = pageTitle
    }
        
// MARK: Configure TableView
    func configureTableView() {
        addRefreshControl()
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
    }
    
    // MARK: Add refreshcontrol
    func addRefreshControl() {
        refreshcontrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshcontrl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tableView.addSubview(refreshcontrl)
    }
    
    // MARK: Action of refreshcontrol
    @objc func refresh() {
        setDataSourceandDelegate()
    }
    
}
