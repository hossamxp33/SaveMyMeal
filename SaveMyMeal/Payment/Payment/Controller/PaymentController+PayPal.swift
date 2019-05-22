//
//  PaymentController+PayPal.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/13/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation

extension PaymentController : PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate{
   
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        self.resetTheAmounts()
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]) {
        
    }
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        self.resetTheAmounts()
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable : Any]) {
        
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true)
        self.resetTheAmounts()
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        MakeCartObject(Type: "paypal")
        addOrders(type: "paypal")
        
    }
    
    func MakeCartObject(Type:String){
       // let defualts = UserDefaults.standard
        if LoginModel.isLogged {
            
            var arrOfObjects : [[String:String]] = []
            
            for object in cartIDsEntity.cartItems {
                let orderItem : [String : String] = [
                    "restaurant_id" : String(object.id!),
                    "user_id" : String(LoginModel.UserId),
                    "amount" : String(object.count!),
                    "total" : String(Double(object.price! * Double(object.count!))),
                    "type" : Type
                ]
                arrOfObjects.append(orderItem)
                let price =  "\(round(object.price! * dollarRate*100)/100)"

                payPalItems.append(PayPalItem(name: object.name!, withQuantity: UInt(object.count!), withPrice: NSDecimalNumber(string: price), withCurrency: "USD", withSku: "Hip-0037"))
            }
            smallObject = ["Order":arrOfObjects]
        }else {
            
            //Alert.AlertVariable.ShowSettings(message: "يجب تسجيل الدخول")
        }
    }
    
    func PayPALPayment(Type:String) {
        payPalConfig.acceptCreditCards = true
        payPalConfig.merchantName = "ShopGate"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        print(smallObject)
        let subtotal = PayPalItem.totalPrice(forItems: payPalItems)
        let shipping = NSDecimalNumber(string: "0")
        let tax = NSDecimalNumber(string: "0")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let totals = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: totals, currencyCode: "USD", shortDescription: "ShopGate", intent: .sale)
        
        payment.items = payPalItems
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
        
        
    }
}
