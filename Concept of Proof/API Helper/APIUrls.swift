//
//  APIUrls.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation

// MARK: API list
enum APIUrl: String {
    case listApi = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

// MARK: Get Custome Error Message
func getCustomeErrorMessage(error: Error) -> String {
    let eror = error as NSError
    switch eror.code {
    case -1009:
        return "Internet not available, Cross check your internet connectivity and try again"
    case -1001:
        return "The request timed out, Please try again later"
    default:
        return eror.localizedDescription
    }
    
}
