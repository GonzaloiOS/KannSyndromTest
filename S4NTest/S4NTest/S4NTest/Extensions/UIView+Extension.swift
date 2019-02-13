//
//  UIView+Extension.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

extension UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
