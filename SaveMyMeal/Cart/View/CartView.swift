//
//  CartView.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/21/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

class CartView: BaseCell{
    var count = 1 {
        didSet{
            CountLabel.text = String(count)
        }
    }
    var cartCollectionProtocol: CartCollectionViewProtocol?
    var data : RestaurantViewModel? {
        didSet{
            self.proImage.loadImageUsingUrlString(data?.logo ?? "")
            self.priceLabel.text = "\(data?.price ?? 0.0) L.E"
            self.amountLabel.text = (data?.startTimeJoined ?? "00:00") + " - " + (data?.endTimeJoined ?? "00:00")
            self.titleLabel.text = data?.name
        }
    }
    //MARK: - Actions -
    @objc func plusButtonClicked(){
        if (data?.amount)! > count {
            count = count + 1
        
            cartIDsEntity.IncreaseCount(of: (data?.id)!)
            cartCollectionProtocol?.updateTotal()
        }else{
            showWarningMessages(body: "Sorry there is no available amount")
        }
    }
    @objc func minusButtonClicked(){
        if count > 1 {
            count = count - 1
            
            cartIDsEntity.decreaseCount(of: (data?.id)!)
            cartCollectionProtocol?.updateTotal()
        }
    }
    @objc func deleteButtonClicked(){
        cartIDsEntity.remove(id: (data?.id)!)
        cartCollectionProtocol?.refreshForItemRemovedWith(id: (data?.id)!)
    }
    override func setupViews() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
        
        
        self.contentView.addSubview(proImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(amountLabel)
        self.contentView.addSubview(countStack)
        countStack.addArrangedSubview(plusButton)
        countStack.addArrangedSubview(CountLabel)
        countStack.addArrangedSubview(minusButton)
        self.contentView.addSubview(deleteButton)
        
        
        NSLayoutConstraint.activate([
        //ProImage
        proImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        proImage.widthAnchor.constraint(equalTo: proImage.heightAnchor),
        proImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        proImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        
        //TitleLAbel
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
        titleLabel.leadingAnchor.constraint(equalTo: proImage.trailingAnchor, constant: 15),
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor,constant: -15),
        
       
        //PriceLabel
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
        priceLabel.leadingAnchor.constraint(equalTo: proImage.trailingAnchor, constant: 25),
        
         //AmountLabel
        amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
        amountLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 70),
        
        //AddToCountStack
        countStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        countStack.heightAnchor.constraint(equalToConstant: 20),
        countStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        
        //PlusButton
        plusButton.widthAnchor.constraint(equalToConstant: 20),
        minusButton.widthAnchor.constraint(equalToConstant: 20),
       
        //delete button
        deleteButton.heightAnchor.constraint(equalToConstant: 25),
        deleteButton.widthAnchor.constraint(equalToConstant: 25),
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
        
    }
    //proImage
    private let proImage : CustomImageView = {
      let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "retaurantLogo")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    //titleLabel
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Wok House Sushi Bar & Asian food"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //priceLabel
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "180 L.E"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //amountLabel
    private let amountLabel : UILabel = {
        let label = UILabel()
        label.text = "10 Left"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.textColor = #colorLiteral(red: 0.3330949545, green: 0.5352105498, blue: 0.668555975, alpha: 1)
        label.font = UIConstants.LightFont.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //countStack
    private let countStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    //PlusButton
   lazy var plusButton : RoundedButton = {
       let button = RoundedButton()
        button.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitle("+", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.25
        button.titleLabel?.font = UIConstants.LightFont.withSize(28)
        button.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //CountLabel
    private let CountLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.font = UIConstants.LightFont.withSize(14)
        label.textAlignment = .center
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MinusButton
     lazy var minusButton : RoundedButton = {
        let button = RoundedButton()
        button.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitle("-", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.25
        button.titleLabel?.font = UIConstants.LightFont.withSize(30)
        button.addTarget(self, action: #selector(minusButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //DeleteButton
    private lazy var deleteButton : UIButton = {
       let button = UIButton()
        button.tintColor = .red
        button.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        return button
    }()
    
}
