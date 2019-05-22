//
//  CartController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/21/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class CartController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var presenter : CartPresenterProtocol?
    var cartData : [RestaurantViewModel] = []
    var total : Double = 0.0 {
        didSet{
            self.totalLabel.text = "\(total) L.E"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            presenter = CartRouter.createModule(controller: self)
        }
        productsCollectionView.register(CartView.self, forCellWithReuseIdentifier: cell)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        self.backButton.isHidden = true
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCart()
        
        
    }
    func reloadCart(){
        cartData = []
        
        self.total = cartIDsEntity.cartTotal
        if total == 0.0 {
            self.productsCollectionView.reloadData()
            return
        }
        print(cartIDsEntity.cartItems)
        for item in cartIDsEntity.cartItems {
            
            presenter?.getRestInfo(restID: item.id! ){ (restIfo) in
                if restIfo != nil{
                    self.cartData.append(restIfo!)
        //            self.total = self.total + (Int(restIfo?.price ?? "0") ?? 0)
                    self.productsCollectionView.reloadData()
                }
            }
        }
    }
    @objc func checkButtonClicked(){
        
        
        if cartIDsEntity.cartTotal == 0.0 {
            showWarningMessages(body: "Your cart is empty")
        }else{
            if !LoginModel.isLogged{
                let alert = UIAlertController(title: "Login required", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Login", style: .default, handler:
                    {action in
                        self.navigationController?.pushViewController(LoginController().self,animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                return
            }
            
           self.navigationController?.pushViewController(PaymentController().self, animated: true)
        }
    }
    //MARK: - CollectionView -
    var cell = "cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cartData.count == 0 {
            emptyCartLabel.isHidden = false
        }else{
            emptyCartLabel.isHidden = true
        }
        return cartData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! CartView
        cell.data = cartData[indexPath.row]
        cell.cartCollectionProtocol = self
        cell.count = cartIDsEntity.cartItems[indexPath.row].count!
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(collectionView.frame.size.width), height: 120)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RestaurantDetailsRouter.navigateToRestaurantDetailsController(data: cartData[indexPath.row], controller: self)
    }
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = UIConstants.AppBGColor
        
        view.addSubview(checkOutButton)
        NSLayoutConstraint.activate([
           checkOutButton.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 40),
           checkOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
           checkOutButton.heightAnchor.constraint(equalToConstant: 30),
           checkOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        view.addSubview(pageTitleLabel)
        NSLayoutConstraint.activate([
           pageTitleLabel.centerYAnchor.constraint(equalTo: checkOutButton.centerYAnchor),
           pageTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        view.addSubview(totalLabel)
        NSLayoutConstraint.activate([
           totalLabel.centerYAnchor.constraint(equalTo: checkOutButton.centerYAnchor),
           totalLabel.trailingAnchor.constraint(equalTo: checkOutButton.leadingAnchor, constant: -10)
        ])
        view.addSubview(productsCollectionView)
        NSLayoutConstraint.activate([
           productsCollectionView.topAnchor.constraint(equalTo: checkOutButton.bottomAnchor, constant: 20),
           productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
           productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
           productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.addSubview(emptyCartLabel)
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    //pageTitleLabel
    private let pageTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "Cart"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //totalLabel
    private let totalLabel : UILabel = {
        let label = UILabel()
        label.text = "Total: 0 L.E"
        label.textColor = .black
        label.font = UIConstants.LightFont.withSize(15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emptyCartLabel : UILabel = {
        let label = UILabel()
        label.text = "Cart is empty"
        label.textColor = .darkGray
        label.font = UIConstants.LightFont.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //CheckOutButton
    lazy var checkOutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.AppColor
        button.setTitle("Check Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.checkButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //CollectionView
    let productsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
}
