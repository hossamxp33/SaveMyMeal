//
//  ContactUsController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/16/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class ContactUsController: BaseViewController,UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentRect = CGRect.zero
        
        for view in contentView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = CGSize(width:contentRect.size.width, height: contentRect.size.height + 20)
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Message"
        }
    }
    @objc func sendButtonClicked(){
        
    }
    
    //MARK : - UI -
    override func setupViews() {
        super.setupViews()
        
        self.view.backgroundColor = UIConstants.AppBGColor
        
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        self.scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        
        
        
        self.contentView.addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        logoImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.17).isActive = true
        logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor, multiplier: 1).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        self.contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.37).isActive = true
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(mobileTextField)
        
        self.contentView.addSubview(messageTextView)
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            messageTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            messageTextView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            messageTextView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ])
        
        
        self.contentView.addSubview(sendButton)
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        sendButton.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 25).isActive = true
        sendButton.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor).isActive = true
        
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
    let logoImage : CustomImageView = {
        let image = CustomImageView()
        image.image = #imageLiteral(resourceName: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Name",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let mobileTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Mobile",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let messageTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Message"
        textView.font = UIConstants.LightFont.withSize(17)
        textView.textColor = .black
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = UIColor.white
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(17)
        button.backgroundColor = UIConstants.AppColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}
