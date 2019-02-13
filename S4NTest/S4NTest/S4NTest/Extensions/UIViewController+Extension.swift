//
//  UIView+Extension.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

struct UIViewControllerExtensionConfig {
    static let defaultButtonText = "OK"
}

extension UIViewController {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    func presentAlertController(title: String?, message:String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: UIViewControllerExtensionConfig.defaultButtonText, style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
