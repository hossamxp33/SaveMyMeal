//
//  WebViewVC.swift
//  DigitalSecurity
//
//  Created by Hadeer Kamel on 4/16/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: BaseViewController ,WKUIDelegate,WKNavigationDelegate{
    
    //@IBOutlet weak var navigationTitleLabel: LocalizableLabel!
    
    var path = ""
    var pageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationTitleLabel.text = pageTitle
        webView.uiDelegate = self
        webView.navigationDelegate = self
        loadSpinner.startAnimating()
        
        let url = URL(string: path)
        let request = URLRequest(url:url!)
        webView.load(request)
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadSpinner.isHidden = true
    }
    
    override func setupViews() {
        super.setupViews()
        self.view.addSubview(webView)
        self.view.addSubview(loadSpinner)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadSpinner.heightAnchor.constraint(equalToConstant: 35),
            loadSpinner.widthAnchor.constraint(equalToConstant: 35)
        ])
        loadSpinner.center = view.center
        loadSpinner.startAnimating()
    }
    
    let webView: WKWebView = {
        let webView_ = WKWebView()
        
        webView_.translatesAutoresizingMaskIntoConstraints = false
        return webView_
    }()
    
    let loadSpinner: UIActivityIndicatorView = {
        let activityIndicator  = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge )
        activityIndicator.startAnimating()
        activityIndicator.color = .gray
        return activityIndicator
    }()
}


