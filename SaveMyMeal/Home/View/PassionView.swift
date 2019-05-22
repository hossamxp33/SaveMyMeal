//
//  PassionView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/16/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class PassionView : BaseCell {
    var title : String? {
        didSet{
            titleLabel.text = title
        }
    }
    var selected_ : Bool = false {
        didSet{
            if selected_ {
            
              self.contentView.layer.borderWidth = 1.0
                
            }else{
                self.contentView.layer.borderWidth = 0.0
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        selected_ = false
    }
    override func setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.9014149308, green: 0.9176202416, blue: 0.9258813262, alpha: 1)
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    }
    let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "ASIAN"
        label.textAlignment = .center
        label.font = UIConstants.LightFont.withSize(17)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
