//
//  asdffgg.swift
//  MakeUp
//
//  Created by hossam ahmed on 2/24/19.
//  Copyright © 2019 hossam ahmed. All rights reserved.
//

import UIKit
class MyOrderController : BaseViewController,  UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var cell = "ordersCell"
    var presenter : MyOrderPresenterProtocol?
    var data : [MyOrdersViewModel] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginModel.isLogged{
            
            presenter?.getMyOrders(id: LoginModel.UserId) { (orders) in
                self.data = orders
                self.ordersCollectionView.reloadData()
            }
        }else{
            let alert = UIAlertController(title: "Login required", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler:
                {action in
                    self.navigationController?.pushViewController(LoginController().self,animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:{
                action in
                self.tabBarController?.selectedIndex = 0
            }))
            
            self.present(alert, animated: true)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersCollectionView.register(MyOrderView.self, forCellWithReuseIdentifier: cell)
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
        //refershControl
        if #available(iOS 10.0, *) {
            ordersCollectionView.refreshControl = refreshControl
        } else {
            ordersCollectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(self.reloadOrders), for: .valueChanged)
        
        
        self.backButton.isHidden = true
        
        if presenter == nil{
            presenter = MyOrdersRouter.createModule(controller: self)
        }
       
        
        
        
        
        // setup navBar.....
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor.white
        var titleLabel = UILabel()
        titleLabel = UILabel(frame: CGRect(x:view.frame.width/2, y: 20, width:0, height: view.frame.height))
        titleLabel.text = NSLocalizedString("العناية بالشعر", comment: "this is name")
        titleLabel.textColor = UIColor.black
        let font = UIFont(name: "JFFlat-Regular", size: 14)
        titleLabel.font = font
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        
        
        
        
        //Load orders
    }

    @objc func reloadOrders(){
        presenter?.getMyOrders(id: LoginModel.UserId) { (orders) in
            self.data = orders
            self.ordersCollectionView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
    //MARK: - CollectionView -
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! MyOrderView
        cell.data = data[indexPath.row]
        cell.presenter = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(collectionView.frame.size.width), height: 260)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = UIConstants.AppBGColor
        
        view.addSubview(pageTitleLabel)
        view.addSubview(ordersCollectionView)
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 30),
            pageTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
            ordersCollectionView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20),
            ordersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ordersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ordersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private let ordersCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let pageTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "My orders"
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ///////// search View
  
    
  
}



