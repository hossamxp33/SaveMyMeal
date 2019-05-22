//
//  PaymentMethodView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/17/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodView: BaseCell {
    var data: (name:String,logoImage:UIImage,logoImage2:UIImage?,desc:String,selected:Bool)? {
        didSet{
            self.methodTitle.text = data?.name
            self.methodImage.image = data?.logoImage
            if data?.logoImage2 != nil {
                self.methodImage2.image = data?.logoImage2
            }
            self.descriptionLabel.text = data?.desc
            self.radioButton.setBackgroundImage(((data?.selected ?? false) ? #imageLiteral(resourceName: "radio-button-on") : #imageLiteral(resourceName: "radio-button-off")), for: .normal)
        }
    }
    
    override func setupViews() {
        self.contentView.backgroundColor = .clear
        
        contentView.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        mainView.addSubview(radioButton)
        radioButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        radioButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        radioButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        radioButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        mainView.addSubview(methodTitle)
        methodTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 19).isActive = true
        methodTitle.leftAnchor.constraint(equalTo: radioButton.rightAnchor,constant: 10).isActive = true
        
        mainView.addSubview(methodImage)
        methodImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        methodImage.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        methodImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        methodImage.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        mainView.addSubview(methodImage2)
        methodImage2.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        methodImage2.rightAnchor.constraint(equalTo: methodImage.leftAnchor, constant: -5).isActive = true
        methodImage2.widthAnchor.constraint(equalToConstant: 35).isActive = true
        methodImage2.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        mainView.addSubview(descView)
        descView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 50).isActive = true
        descView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -3).isActive = true
        descView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -3).isActive = true
        descView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 3).isActive = true
        
        descView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: descView.topAnchor, constant: 5).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descView.bottomAnchor, constant: -5).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: descView.rightAnchor, constant: -10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: descView.leftAnchor, constant: 10).isActive = true
        
    }
    let mainView : UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let radioButton : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "radio-button-on"), for: .normal)
        button.tintColor = UIConstants.AppColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let methodTitle : UILabel = {
       let label = UILabel()
        label.text = "PayPal"
        label.font = UIConstants.BoldFont.withSize(15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let methodImage : UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "PayPalLogo")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let methodImage2 : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let descView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let descriptionLabel : UILabel = {
       let label = UILabel()
        label.text = "Pay via PayPal, you can pay with credit card if you don't have a PayPal account"
        label.font = UIConstants.LightFont.withSize(11)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
