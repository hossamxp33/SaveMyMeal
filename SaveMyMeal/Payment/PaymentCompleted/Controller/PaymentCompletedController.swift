//
//  PaymentCompleted.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/14/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class PaymentCompletedController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.isHidden = true
    }
    @objc func switchToOrders () {
        self.tabBarController?.selectedIndex = 1
        self.navigationController?.popToRootViewController(animated: false)
       
        
    }
    override func setupViews() {
        super.setupViews()
        
        self.view.addSubview(donePhoto)
        self.view.addSubview(successMessageLabel)
        self.view.addSubview(switchToOrdersButton)
        
        NSLayoutConstraint.activate([
            donePhoto.heightAnchor.constraint(equalToConstant: min(view.frame.height,view.frame.width) * 0.5),
            donePhoto.widthAnchor.constraint(equalTo: donePhoto.heightAnchor),
            donePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donePhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            successMessageLabel.bottomAnchor.constraint(equalTo: donePhoto.topAnchor, constant: -20),
            successMessageLabel.topAnchor.constraint(greaterThanOrEqualTo: navigationView.bottomAnchor),
            successMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            switchToOrdersButton.heightAnchor.constraint(equalTo: donePhoto.heightAnchor, multiplier: 0.4),
            switchToOrdersButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            switchToOrdersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchToOrdersButton.topAnchor.constraint(equalTo: donePhoto.bottomAnchor, constant: 20),
            switchToOrdersButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        
    }
    let successMessageLabel : UILabel = {
        let label = UILabel()
        label.text = "Thank you,,,The request has completed"
        label.textColor = .black
        label.font = UIConstants.LightFont.withSize(17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let donePhoto : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "checked ")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var switchToOrdersButton : UIButton = {
        let button = UIButton()
        button.setTitle("Switch To my Orders", for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(17)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(switchToOrders), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
