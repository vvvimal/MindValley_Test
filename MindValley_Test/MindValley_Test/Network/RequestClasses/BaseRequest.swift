//
//  BaseRequest.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

// MARK: - BaseRequest protocol for the URLRequest
protocol BaseRequest {
    
    var urlString: String { get }
}

// MARK: - BaseRequest protocol extension
extension BaseRequest {
    
    var urlComponents: URLComponents? {
        return URLComponents(string: urlString)
    }
    
    var request: URLRequest? {
        if let url = urlComponents?.url{
            return URLRequest(url: url)
        }
        return nil
    }
}
