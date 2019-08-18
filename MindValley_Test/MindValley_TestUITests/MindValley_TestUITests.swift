//
//  MindValley_TestUITests.swift
//  MindValley_TestUITests
//
//  Created by Venugopalan, Vimal on 17/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import XCTest

class MindValley_TestUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// test pull to refresh functionality
    func testPullToRefresh() {
        let pinterestCollectionView = app.collectionViews["PinterestCollectionView"]
        XCTAssertTrue(pinterestCollectionView.exists, "The collectionview exists")
        
        customSwipe(refElement: pinterestCollectionView, startdelxy: CGVector(dx: 0.5, dy: 0.2), enddeltaxy: CGVector(dx: 0.5, dy: 1))
        sleep(5)
    }
    
    /// Custom swipe gesture
    ///
    /// - Parameters:
    ///   - refElement: element on which swipe gesture is to be applied
    ///   - startdelxy: start point
    ///   - enddeltaxy: end point
    func customSwipe(refElement:XCUIElement,startdelxy:CGVector,enddeltaxy: CGVector){
        let swipeStartPoint = refElement.coordinate(withNormalizedOffset: startdelxy)
        let swipeEndPoint = refElement.coordinate(withNormalizedOffset: enddeltaxy)
        swipeStartPoint.press(forDuration: 0.05, thenDragTo: swipeEndPoint)
        
    }
    
    
    /// test background reload
    func testBackGroundReload() {
        sleep(5)
        //press home button
        XCUIDevice.shared.press(.home)
        //relaunch app from background
        app.activate()
        sleep(5)
    }

}
