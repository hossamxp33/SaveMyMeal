//
//  RateRestaurant.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/22/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

class RateRestaurantController : BaseViewController {
    
    var restID = 0
    var logoImage = UIImage()
    var restName = ""
    override func setupViews() {
        super.setupViews()
        view.addSubview(restaurantTitleLabel)
        view.addSubview(reviewLabel)
        view.addSubview(restaurantLogo)
        view.addSubview(rateView)
        view.addSubview(rateTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            //restaurantTitle
            restaurantTitleLabel.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 25),
            restaurantTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //reviewLabel
            reviewLabel.centerYAnchor.constraint(equalTo: restaurantTitleLabel.centerYAnchor),
            reviewLabel.leadingAnchor.constraint(equalTo: restaurantTitleLabel.trailingAnchor, constant: 3),
            
            //logoImage
            restaurantLogo.topAnchor.constraint(equalTo: restaurantTitleLabel.bottomAnchor, constant: 25),
            restaurantLogo.widthAnchor.constraint(equalToConstant: (min(view.bounds.size.width,view.bounds.size.height) * 0.6)),
            restaurantLogo.heightAnchor.constraint(equalTo: restaurantLogo.widthAnchor),
            restaurantLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //rateview
            rateView.topAnchor.constraint(equalTo: restaurantLogo.bottomAnchor, constant: 20),
            rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //rateTextField
            rateTextField.topAnchor.constraint(equalTo: rateView.bottomAnchor, constant: 15),
            rateTextField.widthAnchor.constraint(equalTo: rateView.widthAnchor,constant: 30),
            rateTextField.heightAnchor.constraint(equalToConstant: 40),
            rateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //send button
            sendButton.widthAnchor.constraint(equalTo: rateTextField.widthAnchor, constant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: rateTextField.bottomAnchor, constant: 30)
            
        ])
        
    
    }
    private let restaurantTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "WokHouse"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Review"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let restaurantLogo : RoundedImageView = {
       let imageView = RoundedImageView()
        imageView.image = #imageLiteral(resourceName: "retaurantLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let rateView : CosmosView = {
        let rateView = CosmosView()
        rateView.backgroundColor = .clear
        //rateView.semanticContentAttribute = .forceRightToLeft
       // rateView.text = "(342)"
        //rateView.textSize = 9
       // rateView.textColor = .white
        rateView.rating = 0
        rateView.settings.updateOnTouch = true
        rateView.settings.filledImage = #imageLiteral(resourceName: "FilledStar")
        rateView.settings.emptyImage = #imageLiteral(resourceName: "EmptyStar")
        rateView.settings.starSize = 30
        rateView.settings.starMargin = 0
        rateView.translatesAutoresizingMaskIntoConstraints = false
        return rateView
    }()
    private let rateTextField : underLinedTextField = {
        let textField = underLinedTextField()
        
        textField.attributedPlaceholder =  NSAttributedString(string: "Type your opinion",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black , NSAttributedStringKey.font: UIConstants.LightFont.withSize(14)])
        
        textField.font = UIConstants.LightFont.withSize(14)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        //bottomLine
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIConstants.BoldFont.withSize(17)
        button.setTitle("Send", for: .normal)
        button.backgroundColor = UIConstants.AppColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantLogo.image = logoImage
        restaurantTitleLabel.text = restName
    }
    
    @objc func sendButtonClicked(){
    
        
            let parameter : [String : String] = [
                "user_id" : String(LoginModel.UserId),
                "restaurant_id" : String(self.restID),
                "rate" : String(Int(self.rateView.rating)),
                "comment" : self.rateTextField.text ?? ""
            ]
            print(parameter)
            ApiService.SharedInstance.Post(URL: NetworkConstants.addReview, dataarr: parameter) { (data) in
                if data["review"] != nil {
                    showSuccessMessage(body: "Congrates,,Restaurant rated successfully")
                }
                self.navigationController?.popViewController(animated: true)
            }
        
    }
}
