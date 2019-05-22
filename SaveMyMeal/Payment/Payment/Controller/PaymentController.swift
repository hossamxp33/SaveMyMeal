//
//  PaymentController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/17/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import Stripe

class PaymentController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //var customerContext: STPCustomerContext?
   // var paymentContext: STPPaymentContext?
    let cell = "cell"
    var paymentMethods :[(name:String,logoImage:UIImage,logoImage2:UIImage?,desc:String,selected:Bool)] = [
        (name:"PayPal",logoImage:#imageLiteral(resourceName: "PayPalLogo"),logoImage2:nil,desc:"Pay via PayPal, you can pay with credit card if you don't have a PayPal account",selected: true)
       // ,(name:"Stripe",logoImage:#imageLiteral(resourceName: "Stripe"),desc:"Pay with any type of cards",selected: false)
        ,(name:"Payment card",logoImage:#imageLiteral(resourceName: "masterCard"),logoImage2:#imageLiteral(resourceName: "VisaLogo"),desc:"you can pay with credit card",selected:false)
    ]
    var selectedMethodIndex = 0
    
    //PayPal variables
    var payPalItems = [PayPalItem]()
    var smallObject = [String:Any]()
    var payPalConfig = PayPalConfiguration()
    var dollarRate = 0.059
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        methodsCollectionView.register(PaymentMethodView.self, forCellWithReuseIdentifier: cell)
        methodsCollectionView.delegate = self
        methodsCollectionView.dataSource = self
        
        self.totalLabel.text = "\(cartIDsEntity.cartTotal ?? 0) L.E"
       // initPyaments_()
       // getEGP_USDRate()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! PaymentMethodView
        cell.data = paymentMethods[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width)), height: CGFloat(collectionView.frame.size.height*0.49))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //set the selected one
        if(selectedMethodIndex != indexPath.row){
            paymentMethods[selectedMethodIndex].selected = false
            selectedMethodIndex = indexPath.row
            paymentMethods[indexPath.row].selected = true
            collectionView.reloadData()
        }
        
    }
    
    @objc func checkOutButtonClicked(){
         self.decreaseAmount()
         //if selectedMethodIndex == 1 {
           //presentPaymentMethodsViewController()
        //}else{
             // paybal
            self.MakeCartObject(Type: "paypal")
            self.PayPALPayment(Type: "paypal")
       // }
    }
    @objc func termsButtonClicked(){
        self.openURL(stringURL: "")
    }
    func addOrders(type: String){
        if !LoginModel.isLogged{
            let alert = UIAlertController(title: "Login required", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler:
                {action in
                    self.navigationController?.pushViewController(LoginController().self,animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
            
            self.present(alert, animated: true)
            return
        }
        
            
            ApiService.SharedInstance.Login(URL: NetworkConstants.addOrder, dataarr: smallObject) { (response) in
                
                if (response["order"] != nil){
                    // showSuccessMessage(body: "Order added successfully")
                     self.dismiss(animated: true, completion: nil)
                     self.navigationController?.pushViewController(PaymentCompletedController().self, animated: true)
                    // clear the cart
                    cartIDsEntity.clear()
                    self.setCartBadge()
                     //self.dismiss(animated: true, completion: nil)
                }else{
                    showErrorMessage(body: "There is some thing wrong,,Please try again later")
                    
                }
            
        }
    }
    func resetTheAmounts(){
        for item in cartIDsEntity.cartItems {
            updateTheAmountOfRest(amount:item.amount! + item.count!,restID:item.id!)
        }
    }
    func decreaseAmount(){
        for item in cartIDsEntity.cartItems {
            updateTheAmountOfRest(amount:item.amount! - item.count!,restID:item.id!)
        }
    }
    func updateTheAmountOfRest(amount:Int,restID:Int){
        let parameters : [String:String] = [
            "amount" : String(amount)
        ]
        print(parameters)
        let url = NetworkConstants.restAmount + "/\(String(restID)).json"
        ApiService.SharedInstance.Post(URL: url, dataarr: parameters) { (response) in
            print(response)
            cartIDsEntity.changeAmount(id: restID, amount: amount)
        }
    }
    func getEGP_USDRate(){
        
        let parameter : [String : Any] = [
            "access_key" : "2695b5b850c57976234f00bf59885f38",
            "base" : "EGP",
            "symbols" : ["USD"]
        ]
        
        ApiService.SharedInstance.fetchFeedForUrl(URL: "http://data.fixer.io/api/latest?access_key=2695b5b850c57976234f00bf59885f38&base=EGP&symbols=[USD]") { (response) in
            print(response)
//            let success = response["success"] as! Bool
//            if success{
//                self.dollarRate = (response["rates"] as! [String:Double])["USD"] ?? 0.0
//            }
        }
    }
    //MARK: - SetupViews -
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = UIConstants.AppBGColor
        
        view.addSubview(mainView)
        mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        mainView.addSubview(totalLabel)
        totalLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25).isActive = true
        totalLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -15).isActive = true
        
        mainView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(lessThanOrEqualTo: totalLabel.leftAnchor, constant: 0).isActive = true
        
        mainView.addSubview(methodsCollectionView)
        methodsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        methodsCollectionView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        methodsCollectionView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9).isActive = true
        methodsCollectionView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        mainView.addSubview(checkOutButton)
        checkOutButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        checkOutButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        checkOutButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -50).isActive = true
        checkOutButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        mainView.addSubview(termsButton)
        termsButton.topAnchor.constraint(equalTo: checkOutButton.bottomAnchor, constant: 7).isActive = true
        termsButton.centerXAnchor.constraint(equalTo: checkOutButton.centerXAnchor).isActive = true
        
    }
    //mainView
    let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //titleLabel
    let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Payment"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //totalLabel
    let totalLabel : UILabel = {
        let label = UILabel()
        label.text = "Total: 1222 L.E"
        label.textColor = .black
        label.font = UIConstants.LightFont.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //methodsCollectionview
    let methodsCollectionView : UICollectionView = {
       let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //checkOutButton
    lazy var checkOutButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = UIConstants.AppColor
        button.setTitle("Check Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkOutButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var termsButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(11)
        button.setTitle("Terms and Conditions", for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(termsButtonClicked), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

}
