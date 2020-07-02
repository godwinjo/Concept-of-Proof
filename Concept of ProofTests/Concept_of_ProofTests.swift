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
        let itemDetails = ItemDetails(dict: dict as NSDictionary)
        XCTAssert(itemDetails.itemTitle == dict["title"])
        XCTAssert(itemDetails.itemDescription == dict["description"])
        XCTAssert(itemDetails.itemImage == dict["imageHref"])
    }
    
    func testinitializerItem() {
        let dict = ["title": "firt item", "description": "first item description", "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as NSDictionary)
        let array = [itemDetails]
        let dict1 = ["title": "firt item", "rows": [array]] as [String: Any]
        let item = Item()
        item.initValues(dict: dict1 as NSDictionary)
        XCTAssert(item.itemTitle == dict1["title"] as? String)
    }

    func testGetAPIStatusTrue() {
        let url = APIUrl.listApi.rawValue
        APIHelper.getMethod(apiUrl: url) { (status, _, _) in
            XCTAssertTrue(status)
        }
    }
    
    func testGetAPIStatusFalse() {
        let url = "https://http://fyimusi"
        APIHelper.getMethod(apiUrl: url) { (status, _, _) in
            XCTAssertTrue(status)
        }
    }
    
    func testGetAPIGetError() {
        let url = "https://http://fyimusi"
        APIHelper.getMethod(apiUrl: url) { (_, _, error) in
            XCTAssertNotNil(error)
        }
    }
    
    func testAlamofireServiceError() {
        let url = "https://http://fyimusi"
        APIHelper.alamofireGetAPI(url: url) { (_, _, error) in
            XCTAssertNotNil(error)
        }
    }
    
    func testJsonDecoding() {
        let data = Data()
        APIHelper.jsonDecoding(data: data) { (_, _, error) in
            XCTAssertNotNil(error)
        }
    }
    
    func testGetItems() {
        APIManager.getItemsList { (status, result, error) in
            XCTAssertTrue(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func testinitTableView() {
        let homeVc = HomeTableViewController()
        _ = homeVc.view
        homeVc.pageTitle = ""
        homeVc.getItems()
        XCTAssertNotNil(homeVc.tableView)
    }
    
    func testTableViewDataSource() {
        let homeVc = HomeTableViewController()
        XCTAssertTrue(homeVc.tableView.dataSource is Item)
    }
    
    func testItemGetFromItem() {
        let item = Item()
        let statticTitle = "About Canada"
        item.getItems { (status, title, error) in
            XCTAssertTrue(status)
            XCTAssertNotNil(title)
            XCTAssertNil(error)
            XCTAssertEqual(title, statticTitle)
        }
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
               let itemDetails = ItemDetails(dict: dict as NSDictionary)
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, imageView: imageViewItem)
        cell.reUseControls()
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
               let itemDetails = ItemDetails(dict: dict as NSDictionary)
        cell.setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, imageView: imageViewItem)
        cell.reUseControls()
    }
    
    func testTabelViewCellValues() {
        let item = Item()
        let tableView = UITableView()
        tableView.register(ItemDetailsTableViewCell.self, forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
        let indexPath = IndexPath(row: 0, section: 0)
        let dict = ["title": nil, "description": nil, "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as NSDictionary)
        let cell = item.setCells(tableView: tableView, indexPath: indexPath, itemDetails: itemDetails)
        XCTAssertNotNil(cell)
    }
    
    func testNumberOfRowsWithNilValue() {
        let item = Item()
        let count = item.getNumberOfRows(itemDetails: nil)
        XCTAssertEqual(count, 0)
    }
    
    func testNumberOfRowsWithValue() {
        let item = Item()
        let dict = ["title": nil, "description": nil, "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as NSDictionary)
        let count = item.getNumberOfRows(itemDetails: [itemDetails])
        XCTAssertEqual(count, 1)
    }
    
    func testResultValidationWithValue() {
        let dict = ["title": "firt item", "description": "first item description", "imageHref": "https://http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]
        let itemDetails = ItemDetails(dict: dict as NSDictionary)
        let array = [itemDetails]
        let dict1 = ["title": "firt item", "rows": [array]] as [String: Any]
        let item = Item()
        item.resultValidate(status: true, dict: dict1 as NSDictionary, error: nil) { (status, _, _) in
            XCTAssertTrue(status)
        }
    }
    
    func testResultValidationWithOutValue() {
        let item = Item()
        item.resultValidate(status: false, dict: nil, error: nil) { (status, _, _) in
            XCTAssertFalse(status)
        }
    }
    
    func testResultValidationWithError() {
        let item = Item()
        let url = "https://http://fyimusi"
        APIHelper.getMethod(apiUrl: url) { (_, _, staticError) in
            item.resultValidate(status: false, dict: nil, error: staticError) { (_, _, error) in
                XCTAssert(error != nil)
            }
         }
        
    }
}
