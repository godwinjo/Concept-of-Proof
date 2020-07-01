//
//  Concept_of_ProofTests.swift
//  Concept of ProofTests
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import XCTest
@testable import Concept_of_Proof
import Alamofire

class Concept_of_ProofTests: XCTestCase {

    func testAPIServiceName()  {
        var apiServiceName : String?
        XCTAssertNil(apiServiceName)
        apiServiceName = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        XCTAssertEqual(apiServiceName, APIUrl.listApi.rawValue)
    }
    
    func apiResponseCheck()  {
        var status : Bool?
        XCTAssertNil(status)
        status = true
        var value : Bool?
        Alamofire.request(APIUrl.listApi.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            value = (response.data != nil) ? true : false
        }
         XCTAssertEqual(status, value)
        
    }
    

}
