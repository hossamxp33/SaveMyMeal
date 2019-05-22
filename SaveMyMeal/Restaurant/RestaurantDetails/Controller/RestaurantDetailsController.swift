//
//  RestaurantDetailsController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/18/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import Stripe

class RestaurantDetailsController: BaseViewController {
    var presenter: RestaurantDetailsPresenterProtocol?
    var data: RestaurantViewModel? {
        didSet{
            restaurantInfoView.data = data
            descriptionLabel.text = data?.description
            self.viewDidLayoutSubviews()
            if cartIDsEntity.cartItems.contains(where: {$0.id == data?.id}) || data?.amount == 0 {
                disableOrdering()
            }
        }
    }
    var count : Int = 1 {
        didSet{
            countLabel.text = "\(count ?? 1)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil{
            presenter = RestaurantDetailsRouter.createModule(controller: self)
        }
       //
    }
    override func viewWillAppear(_ animated: Bool) {
        if cartIDsEntity.cartItems.contains(where: {$0.id == data?.id}){
            disableOrdering()
            cartIDsEntity.getItem(of: data?.id ?? -1) { (index, item) in
                if let item = item {
                    self.count = item.count!
                }
            }
        }else{
           
            self.count = 1
            enableOrdering()
        }
    }
    @objc func addToCartButtonClicked(){
        
        if (data?.amount)! != 0 {
        //addToCart and make the button not clickable
            presenter?.addToCart(restID: (data?.id)!, price: data?.price ?? 0.0,count: Int(countLabel.text ?? "1") ?? 1,name: data?.name ?? " ",amount: data?.amount ?? 1)
            disableOrdering()
            self.setCartBadge()
            showSuccessMessage(body: "Product added to your cart successfully")
        }else{
            showErrorMessage(body: "Sorry,,This product is sold out")
        }
    }
    func disableOrdering(){
        setAddToCartButton_Off()
        setPlus_MinusButtons_Off()
    }
    func enableOrdering(){
        setAddToCartButton_ON()
        setPlus_MinusButtons_ON()
    }
    func setAddToCartButton_Off(){
        addToCartButton.alpha = 0.5
        addToCartButton.setTitle("Added to the cart", for: .normal)
        addToCartButton.isUserInteractionEnabled = false
    }
    func setAddToCartButton_ON(){
        addToCartButton.alpha = 1
        addToCartButton.setTitle("Add To Cart", for: .normal)
        addToCartButton.isUserInteractionEnabled = true
    }
    func setPlus_MinusButtons_Off(){
        self.minusView.isUserInteractionEnabled = false
        self.plusView.isUserInteractionEnabled = false
        self.minusView.alpha = 0.5
        self.plusView.alpha = 0.5
    }
    func setPlus_MinusButtons_ON(){
        self.minusView.isUserInteractionEnabled = true
        self.plusView.isUserInteractionEnabled = true
        self.minusView.alpha = 1
        self.plusView.alpha = 1
    }
    @objc func plusViewClicked(){
        if (data?.amount)! > count {
           count = count + 1
        }else{
            showWarningMessages(body: "Sorry there is no avilable amount")
        }
    }
    @objc func minusViewClicked(){
        if count > 1{
            count =  count - 1
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentRect = CGRect.zero
        
        for view in contentView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = CGSize(width:contentRect.size.width, height: contentRect.size.height + 20)
//        if scrollView.subviews.contains(contentView){
//            contentView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height).isActive = true
//        }
    }
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = UIConstants.AppBGColor
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
           // contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(restaurantInfoView)
        restaurantInfoView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: -10).isActive = true
        restaurantInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
        restaurantInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: -10).isActive = true
        restaurantInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        contentView.addSubview(QuantityTitleLabel)
        NSLayoutConstraint.activate([
            QuantityTitleLabel.topAnchor.constraint(equalTo: restaurantInfoView.bottomAnchor, constant: 10),
            QuantityTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25)
        ])
        
        contentView.addSubview(countStack)
        NSLayoutConstraint.activate([
            countStack.topAnchor.constraint(equalTo:QuantityTitleLabel.bottomAnchor , constant: 10),
            countStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            countStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            countStack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        
        countStack.addArrangedSubview(plusView)
        countStack.addArrangedSubview(countLabel)
        countStack.addArrangedSubview(minusView)
        
        NSLayoutConstraint.activate([
            plusView.widthAnchor.constraint(equalTo: plusView.heightAnchor),
            minusView.widthAnchor.constraint(equalTo: minusView.heightAnchor)
        ])
        
        plusView.addSubview(plusLabel)
        NSLayoutConstraint.activate([
            plusLabel.centerXAnchor.constraint(equalTo: plusView.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: plusView.centerYAnchor)
        ])
        
        minusView.addSubview(minusLabel)
        NSLayoutConstraint.activate([
            minusLabel.centerXAnchor.constraint(equalTo: minusView.centerXAnchor),
            minusLabel.centerYAnchor.constraint(equalTo: minusView.centerYAnchor)
        ])
        
        contentView.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.topAnchor.constraint(equalTo: countStack.bottomAnchor, constant: 15).isActive = true
        descriptionTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 25).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 35).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        
        self.contentView.addSubview(addToCartButton)
        addToCartButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40).isActive = true
        addToCartButton.heightAnchor.constraint(equalTo: restaurantInfoView.heightAnchor, multiplier: 0.2).isActive = true
        addToCartButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
        addToCartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       return scrollView
    }()
    let restaurantInfoView : RestaurantView = {
       let view = RestaurantView()
        view.translatesAutoresizingMaskIntoConstraints = false
      //  view.isUserInteractionEnabled = false
     //   view.contentView.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let QuantityTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Quantity"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //stack
     lazy var countStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 15
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    //plusView
    lazy var plusView : RoundedView = {
        let view = RoundedView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusViewClicked)))
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //PlusLabel
    private let plusLabel : UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        label.textColor = UIConstants.AppColor
        label.font = UIConstants.BoldFont.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MinusView
     lazy var minusView : RoundedView = {
        let view = RoundedView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(minusViewClicked)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MinusLabel
    private let minusLabel : UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.textColor = UIConstants.AppColor
        label.font = UIConstants.BoldFont.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //CountLabel
    private let countLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "Description"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(19)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    private let descriptionLabel : UILabel = {
       let label = UILabel()
        label.text = "Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy Pickup a juicy "
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = UIConstants.LightFont.withSize(13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //checkOutButton
    lazy var addToCartButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.AppColor
        button.setTitle("Add To Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.BoldFont.withSize(20)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToCartButtonClicked), for: .touchUpInside)
        return button
    }()
    
    

}
