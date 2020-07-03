//
//  APIHelper.swift
//  Concept of Proof
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation
import Alamofire

class APIHelper {
    
    // MARK: Get Method
    class func getMethod(apiUrl: String, completion:@escaping (_ status: Bool, _ result: [String: Any]?, _ error: Error?) -> Void) {
    APIHelper.alamofireGetAPI(url: APIUrl.listApi.rawValue) { (status, result, error) in
        completion(status, result, error)
        }
    }
    
    // MARK: Alamofire GET method
    class func alamofireGetAPI(url: String, completion:@escaping (_ status: Bool, _ result: [String: Any]?, _ error: Error?) -> Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (responseData) in
            if let data = responseData.result.value {
                APIHelper.jsonDecoding(data: data) { (status, result, error) in
                    completion(status, result, error)
                }
            } else if responseData.error != nil {
                completion(false, nil, responseData.error)
            }
        }
    }
    
    // MARK: JSON Decoding
    class func jsonDecoding(data: Data, completion:@escaping (_ status: Bool, _ result: [String: Any]?, _ error: Error?) -> Void) {
        do {
            let datastring = String(data: data, encoding: String.Encoding.isoLatin1)
            if let stringData = datastring?.data(using: String.Encoding.utf8) {
                let jsonValue = try JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as AnyObject
                completion(true, (jsonValue as? [String: Any]), nil)
            }
        } catch let error {
            completion(false, nil, error)
        }
    }
    
}
