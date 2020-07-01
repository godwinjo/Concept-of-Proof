//
//  Extensions.swift
//  Concept of Proof
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
