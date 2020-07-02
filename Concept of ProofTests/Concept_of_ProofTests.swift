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
        
        let dict = ["title": "firt item", "rows": []] as [String: Any]
        let item = Item(dict: dict as NSDictionary)
        XCTAssert(item.itemTitle == dict["title"] as? String)
    }

    func testGetAPI() {
        let url = APIUrl.listApi.rawValue
        var apiStatus = Bool()
        APIHelper.getMethod(apiUrl: url) { (status, result, error) in
            apiStatus = status
            XCTAssertEqual(apiStatus, true)
            XCTAssert(result != nil)
            XCTAssert(error == nil)
        }
    }
    
    func testGetItems() {
        var apiStatus = Bool()
        APIManager.getItemsList { (status, result, error) in
            apiStatus = status
            XCTAssertEqual(apiStatus, true)
            XCTAssert(result != nil)
            XCTAssert(error == nil)
        }
    }
}
