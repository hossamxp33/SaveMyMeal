//
//  PaymentController+Stripe.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import Stripe
extension PaymentController : //STPPaymentContextDelegate,
    STPAddCardViewControllerDelegate
    //,STPPaymentOptionsViewControllerDelegate
{
//    func paymentOptionsViewController(_ paymentOptionsViewController: STPPaymentOptionsViewController, didFailToLoadWithError error: Error) {
//        navigationController?.isNavigationBarHidden = true
//        print(error)
//    }
//
//    func paymentOptionsViewControllerDidFinish(_ paymentOptionsViewController: STPPaymentOptionsViewController) {
//        navigationController?.isNavigationBarHidden = true
//    }
//
//    func paymentOptionsViewControllerDidCancel(_ paymentOptionsViewController: STPPaymentOptionsViewController) {
//        navigationController?.isNavigationBarHidden = true
//    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController,
                               didCreateToken token: STPToken,
                               completion: @escaping STPErrorBlock) {
        //UseChargeApi
        navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
        
    }
//    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
//        print(error)
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.popViewController(animated: true)
//    }
//
//    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
//
//    }
//
//    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
//
//    }
//
//    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.popViewController(animated: true)
//    }
//
//    func paymentOptionsViewController(_ paymentOptionsViewController: STPPaymentOptionsViewController, didSelect paymentOption: STPPaymentOption) {
//         navigationController?.isNavigationBarHidden = true
//    }
//
//    func initPyaments_ (){
//        customerContext = STPCustomerContext(keyProvider: MainAPIClient.shared)
//        paymentContext = STPPaymentContext(customerContext: customerContext!)
//
//        paymentContext?.delegate = self
//        paymentContext?.hostViewController = self
//
//    }
    func presentPaymentMethodsViewController() {
        guard !STPPaymentConfiguration.shared().publishableKey.isEmpty else {
            // Present error immediately because publishable key needs to be set
            let message = "Please assign a value to `publishableKey` before continuing. See `AppDelegate.swift`."
            //  present(UIAlertController(message: message), animated: true)
            print(message)
            return
        }
        
        // Present the Stripe payment methods view controller to enter payment details
        self.navigationController?.isNavigationBarHidden = false
        // paymentContext?.presentPaymentOptionsViewController()
        
        
        
        //        let paymentOptionsViewController = STPPaymentOptionsViewController(configuration: STPPaymentConfiguration.shared(), theme: STPTheme.default(), customerContext: customerContext!, delegate: self)
        //
        //        navigationController?.pushViewController(paymentOptionsViewController, animated: true)
        
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        navigationController?.pushViewController(addCardViewController, animated: true)
        
        
        
        //present(addCardViewController,animated: true)
        
        
        
//        guard !MainAPIClient.shared.baseURLString.isEmpty else {
//            // Present error immediately because base url needs to be set
//            let message = "Please assign a value to `MainAPIClient.shared.baseURLString` before continuing. See `AppDelegate.swift`."
//           // present(UIAlertController(message: message), animated: true)
//            print(message)
//            return
//        }
        
        // Present the Stripe payment methods view controller to enter payment details
        
        
    }
}
