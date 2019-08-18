//
//  ImageDownloadRequest.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct ImageDownloadRequest: BaseRequest {
    var urlString: String = ""
    init(urlString: String) {
        self.urlString = urlString
    }
}

class ImageDownloadManager:NetworkManager {
    
    let session: URLSession
    
    /// Init function with URLSession configuration
    ///
    /// - Parameter configuration: URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /// Get Image file download request
    ///
    /// - Parameters:
    ///   - imageFileRequest: In this case BaseRequest for Unit Testing else ImageDownloadRequest
    ///   - completion: ResponseResult consisting of the UIImage or APIError
    func getImageFile(from imageFileRequest: BaseRequest, completion: @escaping (Result<UIImage?, APIError>) -> Void) {
        
        if let requestObj = imageFileRequest.request{
            downloadImage(with: requestObj, completion: completion)
        }
        else{
            completion(.failure(.requestFailed))
        }
        
    }
}

