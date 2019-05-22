//
//  LoginController.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/10/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class LoginController: BaseViewController {

  
    
    
    
    
    
    //var presenter : LoginPresenterProtocol?
    
    var dict : [String:AnyObject] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
    }
   
   @objc func loginButtonClicked(){
    
        guard let userName = userNameTextField.text , userName != "" else {
            //alert for empty username
            print("empty username")
            showWarningMessages(body: "Username Required")
            return
        }
        guard let password = passwordTextField.text , password != "" else {
            //alert for empty password
            print("empty password")
            showWarningMessages(body: "Password Required")
            return
        }
        let parameters : [String:String] = [
            "username" : userName,
            "password" : password
        ]
       print(parameters)
       ApiService.SharedInstance.Login(URL: NetworkConstants.login, dataarr: parameters){ (data) in
        let response = LoginModel(response: data)
        
        
        if !response.success!{
                //showErrorMessage
                
                showErrorMessage(body: response.message!)
            }else{
                //ShowMessageOfLoginSuccess
            
                
                let alert = UIAlertController(title: "Login success", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                    {action in
                        self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true)
            }
       }
    }
    @objc func forgetPassClicked(){
       
        self.pushWebViewVC(path: NetworkConstants.forgetPasslink)
    }
    @objc func FBLoginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile ,.email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
            
//            if error != nil
//            {
//                print(error)
//            }else{
//                print(loginResult)
//            }
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }else{
                    print(error)
                }
            })
        }
    }
    override func setupViews(){
        super.setupViews()
        
        self.view.backgroundColor = UIConstants.AppBGColor
        
        //        self.view.addSubview(titleLabel)
        //        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        //        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        self.view.addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 40).isActive = true
        logoImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.17).isActive = true
        logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor, multiplier: 1).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.17).isActive = true
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        self.view.addSubview(loginButton)
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25).isActive = true
        
        self.view.addSubview(forgetPassButton)
        forgetPassButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        forgetPassButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        
        self.view.addSubview(facebookLoginButton)
        facebookLoginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        facebookLoginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        facebookLoginButton.topAnchor.constraint(equalTo: forgetPassButton.bottomAnchor, constant: 5).isActive = true
        
    }
    
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
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let userNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Username",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font = UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Password",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font = UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIConstants.BoldFont.withSize(17)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIConstants.AppColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(FBLoginButtonClicked), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forgetPassButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(13)
        button.setTitle("Forget password?", for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(forgetPassClicked), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var facebookLoginButton : LoginButton = {
        let fbButton = LoginButton(readPermissions: [ .publicProfile, .email])
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.target(forAction: #selector(FBLoginButtonClicked), withSender: self)
        return fbButton
    }()
}
