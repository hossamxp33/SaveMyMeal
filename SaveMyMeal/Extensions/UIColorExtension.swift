//
//  UIColorExtension.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/8/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    static func rgb(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor{
        return UIColor(red: red/255.0,green: green/255.0,blue: blue/255.0,alpha:1)
    }
}
