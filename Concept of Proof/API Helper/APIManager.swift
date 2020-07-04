//
//  APIManager.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation

class APIManager {
    
    // MARK: Item List API call
    class func getItemsList(completion:@escaping (_ status: Bool, _ item: Item?, _ error: Error?) -> Void) {
        APIHelper.getMethod(apiUrl: APIUrl.listApi.rawValue) { (status, item, error) in
            completion(status, item, error)
        }
    }
}
