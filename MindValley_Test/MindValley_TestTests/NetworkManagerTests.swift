//
//  NetworkManagerTests.swift
//  MindValley_TestTests
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import MindValley_Test

struct UnsuccessfulResponseRequest: BaseRequest {
    
    var urlString: String {
        return "http://pastebin.com/raw/wgkJgazEter"
    }
}

struct RequestFailedRequest: BaseRequest {
    
    var urlString: String {
        return "www.google.com"
    }
}

class NetworkingCallsTests: XCTestCase {
    
    var fetchRequestManager:ImageDetailFetchManager? = ImageDetailFetchManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Testing with an invalid url for unsuccessful response
    func testResponseUnsuccessful() {
        
        let expected = expectation(description: "Check unsucessful response")
        
        fetchRequestManager?.getImageDetail(from: UnsuccessfulResponseRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.responseUnsuccessful)
                XCTAssertEqual(error.message, "Response Unsuccessful")
            }
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    /// Testing with an invalid url for failed response
    func testResponseRequestFailed() {
        
        let expected = expectation(description: "Check request failed response")
        
        fetchRequestManager?.getImageDetail(from: RequestFailedRequest(), completion: {
            result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                expected.fulfill()
                XCTAssertEqual(error, APIError.requestFailed)
                XCTAssertEqual(error.message, "Request Failed")
            }
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    /// Testing with an valid url for successful response
    func testSuccessfulResponse() {
        
        let expected = expectation(description: "Check response is successful")
        
        fetchRequestManager?.getImageDetail(from: ImageDetailFetchRequest(), completion: {
            result in
            switch result {
            case .success(let imageList):
                if imageList != nil{
                    expected.fulfill()
                }
            case .failure( _):
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}

class CacheManagerTests: XCTestCase {
    let session = URLSession(configuration: .default)
    
    /// Testing cache manager with an invalid url
    
    func testCacheManagerRequestFailed(){
        let expected = expectation(description: "Check cache returns nil data")
        
        if let requestObj = RequestFailedRequest().request{
            let task = CacheManager.shared().getData(session: session, request: requestObj, completion: { data, response, error in
                if data == nil{
                    expected.fulfill()
                    
                }
            })
            task?.resume()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    /// Testing cache manager with valid url
    func testCacheManagerSuccessful(){
        let expected = expectation(description: "Check cache returns valid data")
        
        if let requestObj = ImageDetailFetchRequest().request{
            let task = CacheManager.shared().getData(session: session, request: requestObj, completion: { data, response, error in
                if data != nil{
                    expected.fulfill()
                }
            })
            task?.resume()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
