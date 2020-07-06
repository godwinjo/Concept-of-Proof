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

    func testAPIServiceName() {
        var apiServiceName: String?
        XCTAssertNil(apiServiceName)
        apiServiceName = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        XCTAssertEqual(apiServiceName, APIUrl.listApi.rawValue)
    }
    
    func testinitializerItemDetails() {
        let title = "firt item"
        let description = "item description"
        let imaheHref = "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
        let itemDetails = ItemDetails(title: title, description: description, imageHref: imaheHref)
        XCTAssert(itemDetails.title == title)
        XCTAssert(itemDetails.description == description)
        XCTAssert(itemDetails.imageHref == imaheHref)
    }
    
    func testinitializerItem() {
        let title = "firt item"
        let itemDetails = ItemDetails(title: title, description: "item description", imageHref: "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg")
        let rows = [itemDetails]
        let item = Item(title: title, rows: rows)
        XCTAssert(item.title == title)
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
        let imageHref = "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
        let itemDetails = ItemDetails(title: nil, description: nil, imageHref: imageHref)
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, itemImageView: imageViewItem)
        cell.reUseControls()
        XCTAssertEqual(imageHref, cell.itemDetails?.imageHref)
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
        let title = "first Item"
        let itemDetails = ItemDetails(title: "first Item", description: "Item Description", imageHref: "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg")
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, itemImageView: imageViewItem)
        cell.reUseControls()
        XCTAssertEqual(title, cell.itemDetails?.title)
    }
    
    func testTabelViewCellValues() {
        let itemViewModel = ItemViewModel()
        let tableView = UITableView()
        tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
        let indexPath = IndexPath(row: 0, section: 0)
        let itemDetails = ItemDetails(title: nil, description: nil, imageHref: "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg")
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
        let itemDetails = ItemDetails(title: nil, description: nil, imageHref: "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg")
        let count = itemViewModel.getNumberOfRows(itemDetails: [itemDetails])
        XCTAssertEqual(count, 1)
    }
    
}
