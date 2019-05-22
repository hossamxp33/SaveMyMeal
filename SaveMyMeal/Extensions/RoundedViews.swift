//
//  RoundedImageView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/18/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(ovalIn:
            CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
        )).cgPath
        layer.mask = shapeLayer
    }
}

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(ovalIn:
            CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
        )).cgPath
        layer.mask = shapeLayer
    }
}

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = UIBezierPath(ovalIn:
//            CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
//        )).cgPath
//        layer.mask = shapeLayer
        self.layer.cornerRadius = self.bounds.width/2
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
    }
}

