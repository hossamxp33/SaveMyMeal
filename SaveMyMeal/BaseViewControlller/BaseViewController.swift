//
//  BaseViewController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/16/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var socialMediaInfo: [SocialAccount] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.setNavigationBarHidden(true, animated: false)
        //Load Social Links
        ApiService.SharedInstance.fetchFeedForUrl(URL: NetworkConstants.getSocialLinks) { (data) in
            do {
                let links = try JSONDecoder().decode(SocialLinks.self, from: data)
                
                DispatchQueue.main.async (execute: {
                    if links.data != nil && !links.data!.isEmpty{
                        self.socialMediaInfo = links.data!
                    }
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    @objc func facebookButtonClicked(){
        if socialMediaInfo.count >= 4 {
            openURL(stringURL: socialMediaInfo[3].link ?? "")
        }
    }
    @objc func instagramButtonClicked(){
        if socialMediaInfo.count >= 3 {
            openURL(stringURL: socialMediaInfo[2].link ?? "")
        }
    }
    @objc func twitterButtonClicked(){
        if socialMediaInfo.count >= 2 {
            openURL(stringURL: socialMediaInfo[1].link ?? "")
        }
    }
    @objc func youtubeButtonClicked(){
        if socialMediaInfo.count >= 1 {
           openURL(stringURL: socialMediaInfo[0].link ?? "")
        }
    }
    func openURL(stringURL :String){
        let targetURL = URL(string: stringURL)!
        if !UIApplication.shared.canOpenURL(targetURL ) {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL)
        } else {
            UIApplication.shared.openURL(targetURL)
        }
    }
    func pushWebViewVC(path: String){
        let VC = WebViewVC()
        VC.path = path
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @objc func backButtonClicked(){
        backButton.parentViewController?.navigationController?.popViewController(animated: true)
    }
    func setCartBadge() {
        if let tabItems = tabBarController?.tabBar.items {
            tabItems[2].badgeValue = (cartIDsEntity.cartCount == 0) ? nil : String(cartIDsEntity.cartCount)
        }
    }
    func setupViews(){
        view.backgroundColor = UIConstants.AppBGColor
            
        self.view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        navigationView.addSubview(navigationTitle)
        navigationTitle.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 40).isActive = true
        navigationTitle.rightAnchor.constraint(equalTo: navigationView.rightAnchor, constant: -10).isActive = true
        navigationTitle.leftAnchor.constraint(equalTo: navigationView.leftAnchor, constant: 10).isActive = true
        
        navigationView.addSubview(backButton)
        
        
        navigationView.addSubview(socialButtonsStack)
        socialButtonsStack.topAnchor.constraint(equalTo: navigationTitle.bottomAnchor, constant: 3).isActive = true
        socialButtonsStack.widthAnchor.constraint(equalTo: navigationView.widthAnchor, multiplier: 0.45).isActive = true
        socialButtonsStack.heightAnchor.constraint(equalTo: navigationView.heightAnchor, multiplier: 0.35).isActive = true
        socialButtonsStack.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        
        socialButtonsStack.addArrangedSubview(facebookButton)
        socialButtonsStack.addArrangedSubview(InstagramButton)
        socialButtonsStack.addArrangedSubview(twitterButton)
        socialButtonsStack.addArrangedSubview(youtubeButton)
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.centerYAnchor.constraint(equalTo: socialButtonsStack.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 10)
            ])
        
    }
    //navigationBar
    let navigationView : UIView = {
        let view = UIView()
        view.backgroundColor = UIConstants.AppColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //navigationTitle
    let navigationTitle : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "save a delicious meal for the good cause"
        label.font = UIConstants.LightFont.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //socialButtonsStack
    let socialButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    //facebookButton
    lazy var facebookButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        button.addTarget(self, action: #selector(facebookButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //InstagramButton
    lazy var  InstagramButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        button.addTarget(self, action: #selector(instagramButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //twitterButton
    lazy var  twitterButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        button.addTarget(self, action: #selector(twitterButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //youtubeButton
    lazy var youtubeButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "youtube-logo"), for: .normal)
        button.addTarget(self, action: #selector(youtubeButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

}
