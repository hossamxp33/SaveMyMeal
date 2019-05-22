//
//  TextFieldExtension.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/22/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class underLinedTextField : UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomLine()
    }
    func addBottomLine(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
