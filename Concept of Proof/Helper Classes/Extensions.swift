//
//  Extensions.swift
//  Concept of Proof
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import Foundation
import UIKit

// MARK: Constants
let screenWidth = UIScreen.main.bounds.width
let deviceType = UIDevice.current.userInterfaceIdiom

// MARK: String extension
extension String {
    static func className(_ aClass: AnyClass) -> String {
       return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
}

extension UIViewController {
// MARK: Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
