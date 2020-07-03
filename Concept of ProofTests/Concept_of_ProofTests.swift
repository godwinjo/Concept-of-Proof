//
//  Concept_of_ProofTests.swift
//  Concept of ProofTests
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import XCTest
@testable import Concept_of_Proof

class ConceptofProofTests: XCTestCase {
    
    override class func setUp() {
        
    }

    func testAPIServiceName() {
        var apiServiceName: String?
        XCTAssertNil(apiServiceName)
        apiServiceName = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        XCTAssertEqual(apiServiceName, APIUrl.listApi.rawValue)
    }
    
    func testinitializerItemDetails() {
        
        let dict = ["title": "firt item", "description": "first item description", "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        XCTAssert(itemDetails.itemTitle == dict["title"])
        XCTAssert(itemDetails.itemDescription == dict["description"])
        XCTAssert(itemDetails.itemImage == dict["imageHref"])
    }
    
    func testinitializerItem() {
        let dict = ["title": "firt item", "description": "first item description", "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        let array = [itemDetails]
        let dict1 = ["title": "firt item", "rows": [array]] as [String: Any]
        let item = Item(dict: dict1)
        XCTAssert(item.itemTitle == dict1["title"] as? String)
    }

    func testGetAPIStatusTrue() {
        let url = APIUrl.listApi.rawValue
        let expectation = self.expectation(description: "getting items from service")
        APIHelper.alamofireGetAPI(url: url) { (status, _, _) in
            XCTAssertTrue(status)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testGetAPIStatusFalse() {
        let url = ""
        let expectation = self.expectation(description: "getting items from service")
        APIHelper.alamofireGetAPI(url: url) { (status, _, _) in
            XCTAssertFalse(status)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            if let eror = error {
                print(eror)
            }
        }
    }
    
    func testinitTableView() {
        let homeVc = HomeTableViewController()
        _ = homeVc.view
        homeVc.pageTitle = ""
        XCTAssertNotNil(homeVc.tableView)
    }
    
    func testTableViewDataSource() {
        let homeVc = HomeTableViewController()
        XCTAssertTrue(homeVc.tableView.dataSource is ItemViewModel)
    }
    
    func testAlertView() {
        let homeVc = HomeTableViewController()
        homeVc.showAlert(title: "Alert", message: "Message")
    }
    
    func testTableViewCellwithNilValue() {
        let labelTitle = UILabel()
        let labelDescription = UILabel()
        let imageViewItem = UIImageView()
        let views = ["labelTitle": labelTitle, "labelDescription": labelDescription, "imageViewItem": imageViewItem]
        let cell = ItemDetailsTableViewCell()
        cell.contentView.addSubview(labelTitle)
        cell.contentView.addSubview(labelDescription)
        cell.contentView.addSubview(imageViewItem)
        cell.initControlls()
        cell.setConstrainsts(views: views)
        let dict = ["title": nil, "description": nil, "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, itemImageView: imageViewItem)
        cell.reUseControls()
        XCTAssertEqual(dict["title"], cell.itemDetails?.itemTitle)
    }
    
    func testTableViewCellwithValue() {
        let labelTitle = UILabel()
        let labelDescription = UILabel()
        let imageViewItem = UIImageView()
        let views = ["labelTitle": labelTitle, "labelDescription": labelDescription, "imageViewItem": imageViewItem]
        let cell = ItemDetailsTableViewCell()
        cell.contentView.addSubview(labelTitle)
        cell.contentView.addSubview(labelDescription)
        cell.contentView.addSubview(imageViewItem)
        cell.initControlls()
        cell.setConstrainsts(views: views)
        let dict = ["title": "first Item", "description": "Item Description", "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, itemImageView: imageViewItem)
        cell.reUseControls()
        XCTAssertEqual(dict["title"], cell.itemDetails?.itemTitle)
    }
    
    func testTabelViewCellValues() {
        let itemViewModel = ItemViewModel()
        let tableView = UITableView()
        tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
        let indexPath = IndexPath(row: 0, section: 0)
        let dict = ["title": nil, "description": nil, "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        let cell = itemViewModel.setCells(tableView: tableView, indexPath: indexPath, itemDetails: itemDetails)
        XCTAssertNotNil(cell)
    }
    
    func testNumberOfRowsWithNilValue() {
        let itemViewModel = ItemViewModel()
        let count = itemViewModel.getNumberOfRows(itemDetails: nil)
        XCTAssertEqual(count, 0)
    }
    
    func testNumberOfRowsWithValue() {
        let itemViewModel = ItemViewModel()
        let dict = ["title": nil, "description": nil, "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as [String: Any])
        let count = itemViewModel.getNumberOfRows(itemDetails: [itemDetails])
        XCTAssertEqual(count, 1)
    }
    
}
