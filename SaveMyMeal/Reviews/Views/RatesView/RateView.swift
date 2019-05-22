//
//  rateView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/23/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class RateView : BaseCell {
    var rateNumber = 0 {
        didSet{
            rateLabel.text = "\(rateNumber)"
        }
    }
    var rateRasio = 0.0 {
        didSet{
            rateProgress.progress = Float(rateRasio)
        }
    }
    var rateCount = 0 {
        didSet{
            countLabel.text = "( \(rateCount) )"
        }
    }
    override func setupViews() {
        contentView.addSubview(rateLabel)
        contentView.addSubview(rateProgress)
        contentView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            rateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            rateProgress.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            rateProgress.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            rateProgress.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 5),
            rateProgress.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: rateProgress.trailingAnchor, constant: 5)
        ])
    }
    
    private let rateLabel : UILabel = {
        let label = UILabel ()
        label.text = "0"
        label.font = UIConstants.LightFont.withSize(15)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateProgress : UIProgressView = {
       let progressView = UIProgressView()
        progressView.progress = 0
        progressView.trackTintColor = UIConstants.AppBGColor
        progressView.progressTintColor = #colorLiteral(red: 0.9763888717, green: 0.8529962897, blue: 0.1605865061, alpha: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let countLabel : UILabel = {
        let label = UILabel ()
        label.text = "(0)"
        label.font = UIConstants.LightFont.withSize(13)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
