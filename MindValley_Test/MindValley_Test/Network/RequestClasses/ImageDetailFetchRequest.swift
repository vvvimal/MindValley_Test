//
//  ImageDetailFetchRequest.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct ImageDetailFetchRequest: BaseRequest {
    var urlString: String {
        return NetworkData.kBaseURL
    }
}

class ImageDetailFetchManager: NetworkManager {
    
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
    
    /// Get Image detail fetch request
    ///
    /// - Parameters:
    ///   - imageDetailRequest: In this case BaseRequest for Unit Testing else ImageDetailFetchRequest
    ///   - completion: ResponseResult consisting of the ImageDetailModel array or APIError
    func getImageDetail(from imageDetailRequest: BaseRequest, completion: @escaping (Result<[ImageDetailModel]?, APIError>) -> Void) {
        
        if let requestObj = imageDetailRequest.request{
            fetch(with: requestObj, decode: { json -> [ImageDetailModel]? in
                guard let imageDetailModelResult = json as? [ImageDetailModel] else { return  nil }
                return imageDetailModelResult
            }, completion: completion)
        }
        else{
            completion(.failure(.requestFailed))
        }
        
    }
}
