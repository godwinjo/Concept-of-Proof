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
    class func getMethod(apiUrl: String, completion:@escaping (_ status: Bool, _ item: Item?, _ errorMessage: String?) -> Void) {
    APIHelper.alamofireGetAPI(url: APIUrl.listApi.rawValue) { (status, item, errorMessage) in
        completion(status, item, errorMessage)
        }
    }
    
    // MARK: Alamofire GET method
    class func alamofireGetAPI(url: String, completion:@escaping (_ status: Bool, _ item: Item?, _ errorMessage: String?) -> Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (responseData) in
            if let data = responseData.result.value {
                APIHelper.jsonDecoding(data: data) { (status, item, errorMessage) in
                    completion(status, item, errorMessage)
                }
            } else if let eror = responseData.error {
                completion(false, nil, getCustomeErrorMessage(error: eror))
            }
        }
    }
    
    // MARK: JSON Decoding
    class func jsonDecoding(data: Data, completion:@escaping (_ status: Bool, _ item: Item?, _ errorMessage: String?) -> Void) {
        do {
            let datastring = String(data: data, encoding: String.Encoding.isoLatin1)
            if let stringData = datastring?.data(using: String.Encoding.utf8) {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let item = try JSONDecoder().decode(Item.self, from: stringData)
                completion(true, item, nil)
            }
        } catch let error {
            completion(false, nil, getCustomeErrorMessage(error: error))
        }
    }
}
