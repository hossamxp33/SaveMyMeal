//
//  RestaurantView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/16/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit


class RestaurantViewCell : BaseCell {
    var data : RestaurantViewModel? {
        didSet {
            self.mainView.data = data
        }
    }
    override func setupViews() {
        self.contentView.backgroundColor = .clear
        
                contentView.addSubview(mainView)
                mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
                mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
                mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
                mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true

    }
    let mainView : RestaurantView = {
                let view = RestaurantView()
                //view.isUserInteractionEnabled = false
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()

}
