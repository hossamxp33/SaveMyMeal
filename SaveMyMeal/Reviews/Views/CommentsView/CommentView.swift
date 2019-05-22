//
//  CommentView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/23/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class CommentView : BaseCell {
    var data : CommentViewModel?{
        didSet{
            self.rateView.rating = data?.rateStars ?? 0.0
            self.dateLabel.text = data?.date
            self.commentLabel.text = data?.comment
            self.commentPrevLabel.text = data?.comment
            self.commentByLabel.text = data?.userName
        }
    }
    override func setupViews() {
        super.setupViews()
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
        
        contentView.addSubview(rateView)
        contentView.addSubview(commentPrevLabel)
        contentView.addSubview(commentByLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            rateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            rateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            commentPrevLabel.topAnchor.constraint(equalTo: rateView.bottomAnchor, constant: 12),
            commentPrevLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            commentByLabel.topAnchor.constraint(equalTo: commentPrevLabel.bottomAnchor, constant: 12),
            commentByLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            commentLabel.topAnchor.constraint(equalTo: commentByLabel.bottomAnchor, constant: 12),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private let rateView : CosmosView = {
        let rateView = CosmosView()
        rateView.backgroundColor = .clear
       // rateView.semanticContentAttribute = .forceRightToLeft
        rateView.textSize = 9
        rateView.textColor = .white
        rateView.rating = 5
        rateView.settings.updateOnTouch = false
        rateView.settings.filledImage = #imageLiteral(resourceName: "FilledStar")
        rateView.settings.emptyImage = #imageLiteral(resourceName: "EmptyStar")
        rateView.settings.starSize = 15
        rateView.settings.starMargin = 0
        rateView.translatesAutoresizingMaskIntoConstraints = false
        return rateView
    }()
    private let commentPrevLabel : UILabel = {
        let label = UILabel()
        label.text = "Excelent"
        label.textColor = .black
        label.font = UIConstants.LightFont.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let commentByLabel : UILabel = {
        let label = UILabel()
        label.text = "Posted by Ahmed"
        label.textColor = .lightGray
        label.font = UIConstants.BoldFont.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "Very good"
        label.textColor = .lightGray
        label.font = UIConstants.BoldFont.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "01-11-2019"
        label.textColor = .lightGray
        label.font = UIConstants.BoldFont.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
