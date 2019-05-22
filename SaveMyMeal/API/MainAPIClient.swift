//
//  MainAPIClient.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/8/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Alamofire
import Stripe

class MainAPIClient: NSObject, STPEphemeralKeyProvider {
    
    static let shared = MainAPIClient()
    
    var baseURLString = ""
    
    // MARK: Rocket Rides
    
    enum RequestRideError: Error {
        case missingBaseURL
        case invalidResponse
}

    enum CustomerKeyError: Error {
        case missingBaseURL
        case invalidResponse
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let endpoint = "/api/passengers/me/ephemeral_keys"
        
        guard
            !baseURLString.isEmpty,
            let baseURL = URL(string: baseURLString),
            let url = URL(string: endpoint, relativeTo: baseURL) else {
                completion(nil, CustomerKeyError.missingBaseURL)
                return
        }
        
        let parameters: [String: Any] = ["api_version": apiVersion]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            guard let json = response.result.value as? [AnyHashable: Any] else {
                completion(nil, CustomerKeyError.invalidResponse)
                return
            }
            
            completion(json, nil)
        }
    }
    
}
