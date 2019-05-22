//
//  SwiftMessage.swift
//
//
//  Created by Hadeer Kamel on 2/21/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import SwiftMessages

func showMessage(title:String,body:String,type: Theme){
    let view = MessageView.viewFromNib(layout: .cardView)
    
    // Theme message elements with the warning style.
    view.configureTheme((type))
    
    // Add a drop shadow.
    view.configureDropShadow()
    
    // Set message title, body, and icon. Here, we're overriding the default warning
    // image with an emoji character.
    //let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
    view.configureContent(title: title, body: body)
    
    // Increase the external margin around the card. In general, the effect of this setting
    // depends on how the given layout is constrained to the layout margins.
   view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // Reduce the corner radius (applicable to layouts featuring rounded corners).
    //(view.backgroundView as? rounde)?.cornerRadius = 10
    
    // Show the message.
    var config = SwiftMessages.defaultConfig
    config.duration = .seconds(seconds: 3)
    view.button?.isHidden = true
    SwiftMessages.show(config: config,view: view)
    
}

func showErrorMessage(body:String){
    showMessage(title: "Error", body: body, type: .error)
}
func showSuccessMessage(body:String){
    showMessage(title: "SUCCESS", body: body, type: .success)
}
func showWarningMessages(body:String){
    showMessage(title: "WARNING", body: body, type: .warning)
}
