//
//  MyOrderView.swift
//  SaveMyMeal
//
//  Created by hossam ahmed on 2/18/19.
//  Copyright © 2019 hossam ahmed. All rights reserved.
//


import UIKit

class MyOrderView : BaseCell {
    var presenter : orderCellToControllerProtocol?
    var data:MyOrdersViewModel?{
        didSet {
            if data == nil {return}
            self.setOrderStatus(status: ((data!.orderStatus)))
            self.productNumber.text = " Amount : \(String(describing: data!.proCount)) piece"
            self.orderNumberLabel.text = "Order number : \(String(describing: data!.orderID))"
            self.cashLabel.text = "Payment method : \(String(describing: data!.orderType))"
            self.dateLAbel.text = "Order date : \(String(describing: data!.orderDate))"
            self.typenameLabe.text = data!.productName
            if data!.proImage != "" {
                self.itemImage.loadImageUsingUrlString(data!.proImage)
            }
            self.totalLabel.text = "Total : \(data!.total) L.E"
            self.floatRatingView.rating = ((data!.rateStars))
            self.rateNumber.text = "\(String(describing: data!.rateNumber))"
            self.completeButton.setTitle(((data?.orderStatus == 2) ? "Rate" : "Complete"), for: .normal)
        }
    }
    @objc  func completeButtonClicked() {
        if(data?.orderStatus == 1){
            data?.orderStatus = 2
            setOrderStatus(status: 2)
            //use iteractor to update the order
            editOrder(orderID: data?.orderID ?? 0, status: 2)
            completeButton.setTitle("Rate", for: .normal)
            presenter?.presentAlert(title: "Complete order", message: "Order delivered successfuly" )
        }else{
            presenter?.navigateToRateRestaurantController(logo: self.itemImage.image ?? #imageLiteral(resourceName: "retaurantLogo"), restName: self.data?.productName ?? "", restID: data?.restaurant?.id ?? 1)
        }
    }
    func editOrder(orderID: Int, status: Int) {
        
        let urlString = NetworkConstants.editOrder + "/\(orderID).json"
        print(urlString)
        let parameters : [String:String] = [
            "order_status" : String(status)
        ]
        ApiService.SharedInstance.Post(URL: urlString, dataarr: parameters){ (data) in
          print(data)
        }
    }
    func setOrderStatus(status: Int){
        if status >= 1{
            self.setViewOn(view: self.oneView ,label: self.oneLabe )
        }
        if status >= 2{
            self.setViewOn(view: self.twoView, label: self.twoLabe)
        }
    }
    func setViewOn(view :UIView , label: UILabel){
        view.backgroundColor = UIConstants.AppColor
        label.textColor = UIColor.white
    }
    func setViewOff(view :UIView , label: UILabel){
        view.backgroundColor = UIConstants.AppBGColor
        label.textColor = UIColor.lightGray
    }
    override func prepareForReuse() {
        super.prepareForReuse()
       // setViewOff(view: oneView, label: oneLabe)
        setViewOff(view: twoView, label: twoLabe)
        
    }
    override func setupViews() {
        addSubview(mainView)
        self.semanticContentAttribute = .forceLeftToRight
        self.contentView.semanticContentAttribute = .forceLeftToRight
        self.mainView.semanticContentAttribute = .forceLeftToRight
            
        mainView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: widthAnchor,multiplier : 0.9).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        mainView.addSubview(topView)
        topView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: mainView.topAnchor,constant : 30).isActive = true
        topView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9).isActive = true
        topView.heightAnchor.constraint(equalTo: heightAnchor,multiplier : 0.1).isActive = true
        
        
       
        /////// 1 view
        topView.addSubview(oneView)
        oneView.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant : 25).isActive = true
        oneView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        oneView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.13).isActive = true
        oneView.heightAnchor.constraint(equalTo: topView.heightAnchor,multiplier: 1.7).isActive = true
        
        oneView.addSubview(oneLabe)
        oneLabe.centerXAnchor.constraint(equalTo: oneView.centerXAnchor).isActive = true
        oneLabe.centerYAnchor.constraint(equalTo: oneView.centerYAnchor).isActive = true
        
        mainView.addSubview(readyToDelivery)
        readyToDelivery.centerXAnchor.constraint(equalTo: oneView.centerXAnchor).isActive = true
        readyToDelivery.topAnchor.constraint(equalTo: oneView.bottomAnchor,constant : 10).isActive = true
        ////// 3 view
        topView.addSubview(twoView)
        twoView.trailingAnchor.constraint(equalTo: topView.trailingAnchor,constant : -25).isActive = true
        twoView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        twoView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.13).isActive = true
        twoView.heightAnchor.constraint(equalTo: topView.heightAnchor,multiplier: 1.7).isActive = true
        
        twoView.addSubview(twoLabe)
        twoLabe.centerXAnchor.constraint(equalTo: twoView.centerXAnchor).isActive = true
        twoLabe.centerYAnchor.constraint(equalTo: twoView.centerYAnchor).isActive = true
        
        mainView.addSubview(doneDelivery)
        doneDelivery.centerXAnchor.constraint(equalTo: twoView.centerXAnchor).isActive = true
        doneDelivery.topAnchor.constraint(equalTo: twoView.bottomAnchor,constant : 10).isActive = true
        
        
        mainView.addSubview(dateLAbel)
        dateLAbel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor ,constant : 10).isActive = true
        dateLAbel.topAnchor.constraint(equalTo: doneDelivery.bottomAnchor,constant : 10).isActive = true
        
        mainView.addSubview(cashLabel)
        cashLabel.leadingAnchor.constraint(equalTo: dateLAbel.trailingAnchor ,constant : 20).isActive = true
        cashLabel.topAnchor.constraint(equalTo: doneDelivery.bottomAnchor,constant : 10).isActive = true
        cashLabel.trailingAnchor.constraint(lessThanOrEqualTo: mainView.trailingAnchor, constant : -10).isActive = true
        
        mainView.addSubview(orderNumberLabel)
        orderNumberLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor ,constant : 10).isActive = true
        orderNumberLabel.topAnchor.constraint(equalTo: cashLabel.bottomAnchor,constant : 10).isActive = true
        
        mainView.addSubview(totalLabel)
        totalLabel.leadingAnchor.constraint(equalTo: cashLabel.leadingAnchor).isActive = true
        totalLabel.topAnchor.constraint(equalTo: cashLabel.bottomAnchor,constant : 10).isActive = true
        totalLabel.trailingAnchor.constraint(greaterThanOrEqualTo: mainView.trailingAnchor)
        
        mainView.addSubview(itemImage)
        itemImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant : 15).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant : -30).isActive = true
        //itemImage.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor,constant : 10).isActive = true
        itemImage.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.13).isActive = true
        itemImage.heightAnchor.constraint(equalTo: heightAnchor,multiplier : 0.25).isActive = true

        mainView.addSubview(typenameLabe)
        typenameLabe.topAnchor.constraint(equalTo: itemImage.topAnchor,constant : 0).isActive = true
        typenameLabe.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
        typenameLabe.centerXAnchor.constraint(equalTo: centerXAnchor,constant : 20).isActive = true
        typenameLabe.trailingAnchor.constraint(greaterThanOrEqualTo: mainView.trailingAnchor)
        
        mainView.addSubview(floatRatingView)
       // floatRatingView.topAnchor.constraint(equalTo: typenameLabe.bottomAnchor,constant:10).isActive = true
        floatRatingView.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor,constant: 0).isActive = true
        floatRatingView.leadingAnchor.constraint(equalTo: typenameLabe.leadingAnchor,constant : 10).isActive = true
        floatRatingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        floatRatingView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        floatRatingView.editable = false
        floatRatingView.delegate = self as? FloatRatingViewDelegate
        floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        floatRatingView.type = .halfRatings
        floatRatingView.fullImage = #imageLiteral(resourceName: "FilledStar")
        floatRatingView.emptyImage = #imageLiteral(resourceName: "EmptyStar")
        floatRatingView.rating = 5.0

        mainView.addSubview(rateNumber)
        rateNumber.centerYAnchor.constraint(equalTo: floatRatingView.centerYAnchor).isActive = true
        rateNumber.leadingAnchor.constraint(equalTo: floatRatingView.trailingAnchor,constant : 10).isActive = true
    
        mainView.addSubview(productNumber)
        productNumber.topAnchor.constraint(equalTo: floatRatingView.bottomAnchor, constant : 5 ).isActive = true
        productNumber.leadingAnchor.constraint(equalTo: floatRatingView.leadingAnchor).isActive = true
    
        mainView.addSubview(completeButton)
        completeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant : -10).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant : -10).isActive = true
        completeButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.30).isActive = true
        completeButton.heightAnchor.constraint(equalTo: heightAnchor,multiplier : 0.12).isActive = true
        completeButton.isUserInteractionEnabled = true
      
    }
    
    let  mainView :UIView = {
        let uv = UIView()
        uv.backgroundColor = UIColor.white
        uv.layer.cornerRadius = 7
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let itemImage:CustomImageView = {
        let ci = CustomImageView(image: #imageLiteral(resourceName: "retaurantLogo"))
        ci.translatesAutoresizingMaskIntoConstraints = false
        return ci
    }()
    
    let typenameLabe :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(14)// UIFont(name: "DroidArabicNaskh", size: 14)
        NL.font = font
        NL.adjustsFontSizeToFitWidth = true
        NL.minimumScaleFactor = 0.25
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("Wok House Sushi Bar & Asian food", comment: "this is name")
        return NL
    }()
    
    let floatRatingView: FloatRatingView  = {
        let departnames = FloatRatingView()
        departnames.translatesAutoresizingMaskIntoConstraints = false
        return departnames
    }()
    
    let rateNumber  :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.rgb(red:101, green: 101, blue: 101)
        var font = UIConstants.BoldFont.withSize(10)//UIFont(name: "DroidArabicNaskh", size: 10)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("(429)", comment: "this is name")
        return NL
    }()
    
    let  topView :UIView = {
        let uv = UIView()
        uv.backgroundColor = UIColor.rgb(red:230, green: 234, blue: 237)
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.layer.cornerRadius = 7
        return uv
    }()
    

    let  oneView :RoundedView = {
        let uv = RoundedView()
        uv.backgroundColor = UIConstants.AppColor
        uv.translatesAutoresizingMaskIntoConstraints = false
        //uv.layer.borderColor = UIColor.rgb(red:151, green: 151, blue: 151).cgColor
        //uv.layer.borderWidth = 0.5
        //uv.layer.cornerRadius = 24
        //uv.clipsToBounds = true
        return uv
    }()
    
    let oneLabe :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.white
        var font = UIConstants.LightFont.withSize(18)//UIFont(name: "DroidArabicNaskh", size: 18)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("1", comment: "this is name")
        return NL
    }()
    
    
    let readyToDelivery :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.darkGray
        var font = UIConstants.LightFont.withSize(14)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("Ready to ship", comment: "this is name")
        return NL
    }()
    
    

    let  twoView :RoundedView = {
        let uv = RoundedView()
        uv.backgroundColor = UIColor.rgb(red:230, green: 234, blue: 237)
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.layer.borderColor = UIColor.rgb(red:151, green: 151, blue: 151).cgColor
        //uv.layer.borderWidth = 0.5
      //  uv.layer.cornerRadius = 24
        return uv
    }()
    
    let twoLabe :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.lightGray
        var font = UIConstants.LightFont.withSize(18)//UIFont(name: "DroidArabicNaskh", size: 18)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("2", comment: "this is name")
        return NL
       }()

    
        let  doneDelivery:UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.darkGray
        var font = UIConstants.LightFont.withSize(14)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("Delivered", comment: "this is name")
        return NL
       }()
    
       let  dateLAbel :UILabel = {
        let NL = UILabel()
        NL.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(12)// UIFont(name: "DroidArabicNaskh", size: 14)
        NL.font = font
        NL.translatesAutoresizingMaskIntoConstraints = false
        NL.text = NSLocalizedString("Order date: 04 march 2019", comment: "this is name")
        return NL
       }()
    
    
    let cashLabel : UILabel = {
        let ca =  UILabel()
        ca.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(12)//UIFont(name: "DroidArabicNaskh", size: 14)
        ca.font = font
        ca.adjustsFontSizeToFitWidth = true
        ca.minimumScaleFactor = 0.25
        ca.translatesAutoresizingMaskIntoConstraints = false
        ca.text = NSLocalizedString("Payment method: Credit card", comment: "this is name")
       return ca
    }()
    
    
    let  orderNumberLabel : UILabel = {
        let ca =  UILabel()
        ca.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(12)// UIFont(name: "DroidArabicNaskh", size: 14)
        ca.font = font
        ca.translatesAutoresizingMaskIntoConstraints = false
        ca.text = NSLocalizedString("Order number: 111", comment: "this is name")
        return ca
    }()
    
    
    
    
    let totalLabel : UILabel = {
        let ca =  UILabel()
        ca.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(12)// UIFont(name: "DroidArabicNaskh", size: 14)
        ca.font = font
        ca.translatesAutoresizingMaskIntoConstraints = false
        ca.text = NSLocalizedString("Total: 123", comment: "this is name")
        return ca
    }()
    
    let productNumber : UILabel = {
        let ca =  UILabel()
        ca.textColor = UIColor.black
        var font = UIConstants.BoldFont.withSize(12)//UIFont(name: "DroidArabicNaskh", size: 14)
        ca.font = font
        ca.translatesAutoresizingMaskIntoConstraints = false
        ca.text = NSLocalizedString("Amount: 10 piece", comment: "this is name")
        return ca
    }()
    
    lazy var  completeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        button.setTitle(NSLocalizedString("Complete", comment: "this is name"),for: .normal)
        button.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        button.setTitleColor(UIColor.white , for: UIControlState.normal)  ///// how to give it black color and font
        button.layer.cornerRadius = 3
        var font = UIConstants.BoldFont.withSize(14)
        button.titleLabel?.font = font
        return button
        
    }()
  
    
    
}

