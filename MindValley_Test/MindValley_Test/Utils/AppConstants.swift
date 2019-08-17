//
//  AppConstants.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 17/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

/// Network URLs
struct NetworkData {
    static var kBaseURL = "http://pastebin.com/raw/wgkJgazE"
    
}

/// API related errors
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case noInternetError
    
    var message: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .noInternetError: return "No Internet Connection"
        }
    }
}

/// Constant String used in the app
struct AppIdentifierStrings {
    static var kImageCollectionReuseIdentifier = "PinterestCollectionCellIdentifier"
}
