//
//  MindValley_TestTests.swift
//  MindValley_TestTests
//
//  Created by Venugopalan, Vimal on 17/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest
@testable import MindValley_Test

class MindValley_TestTests: XCTestCase {
    var pinterestViewModel:PinterestCollectionViewModel?
    let pinterestView = PinterestCollectionViewController.init(collectionViewLayout: PinterestLayout())
    
    var imageArray:[ImageDetailModel]?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pinterestViewModel = pinterestView.viewModel
        if let imageList = pinterestViewModel?.imageArray{
            imageArray = imageList
            
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageArray = nil
        pinterestViewModel = nil
    }
    
    /// Test if collection view exists
    func testIfCollectionViewExists() {
        pinterestView.loadViewIfNeeded()
        XCTAssertNotNil(pinterestView.collectionView)
    }
    
    /// Test collection view has correct row count
    func testCollectionViewHasCorrectRowCount() {
        pinterestView.loadViewIfNeeded()
        XCTAssertEqual(pinterestView.collectionView.numberOfItems(inSection: 0), imageArray?.count)
    }
    
    /// Test if each cell has correct data
    func testEachCellHasCorrectText() {
        pinterestView.loadViewIfNeeded()
        
        let expected = expectation(description: "Check if data has been fetched")
        expected.expectedFulfillmentCount = 1
        
        pinterestViewModel?.getImageDetailList(completion: {[weak self]
            success, error in
            if success == true{
                expected.fulfill()
                if let imageList = self?.pinterestViewModel?.imageArray{
                    self?.pinterestView.collectionView.reloadSections(IndexSet.init(integer: 0))
                    XCTAssertEqual(self?.pinterestView.collectionView.numberOfItems(inSection: 0), imageList.count)
                    
                    for(index, image) in imageList.enumerated() {
                        let indexPath = IndexPath(item: index, section: 0)
                        if let collectionView = self?.pinterestView.collectionView {
                            if let cell = collectionView.cellForItem(at: indexPath) as? PinterestCollectionViewCell
                            {
                                // do stuff...
                                XCTAssertEqual(cell.nameLabel.text, image.user?.name, "User's name don't match")
                                if let likesCount = image.likes{
                                    XCTAssertEqual(cell.likesLabel.text, String(format: "\(likesCount)👍"), "Image's likes count don't match")
                                }
                                
                            }
                        }
                    }
                }
                else{
                    XCTFail()
                }
            }
            if error != nil{
                XCTFail()
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    /// Test Navigation bar title
    func testNavigationBarHasTitle() {
        pinterestView.loadViewIfNeeded()
        XCTAssertEqual(pinterestView.title, "Pinterest")
    }
}
