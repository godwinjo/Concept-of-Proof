//
//  APIManager.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    

//    MARK:- Item List API call
    class func getItemsList(completion:@escaping (_ status:Bool,_ result:NSDictionary?,_ error : Error?)->Void)  {        Alamofire.request(APIUrl.listApi.rawValue, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseData { (responseData) in
            if let data = responseData.data {
                do {
                    let datastring = String(data: data, encoding: String.Encoding.isoLatin1)
                    let stringData = datastring?.data(using: String.Encoding.utf8)
                    let jsonValue = try JSONSerialization.jsonObject(with: stringData!, options: .mutableContainers) as AnyObject
                    completion(true,(jsonValue as! NSDictionary), nil)
                }catch let error{
                    completion(false,nil, error)
                }
            }
        }
    }
    
}


