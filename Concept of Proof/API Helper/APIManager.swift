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
    class func getItemsList(completion:@escaping (_ status:Bool,_ result:NSDictionary?,_ error : Error?)->Void)  {
        APIHelper.getMethod(apiUrl: APIUrl.listApi.rawValue) { (status, result, error) in
            completion(status,result,error)
        }
    }
    
}


