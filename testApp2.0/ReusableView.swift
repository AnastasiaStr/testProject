//
//  ReusableView.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}
