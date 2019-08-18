//
//  PinterestCollectionViewController.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 17/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class PinterestCollectionViewController: UICollectionViewController {
    
    let viewModel = PinterestCollectionViewModel()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.setupView()
        self.setupCollectionView()
        self.getImageDetail()
    }
    
    func getImageDetail(){
        self.activityStartAnimating()
        viewModel.getImageDetailList(completion: {[weak self] success, error in
            if let errorObj = error{
                self?.setError(error: errorObj)
            }
            else{
                self?.reloadCollectionView()
            }
        })
    }
    
    /// Set up UI elements
    func setupView(){
        self.title = "Pinterest"
    }
    
    /// Setup Collection View properties
    func setupCollectionView(){
        // Register cell classes
        self.collectionView.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: AppIdentifierStrings.kImageCollectionReuseIdentifier)
        self.collectionView.dataSource = viewModel
        self.collectionView.delegate = viewModel
        self.collectionView.accessibilityLabel = "PinterestCollectionView"
        self.collectionView.isAccessibilityElement = true
        self.collectionView.collectionViewLayout = PinterestLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = viewModel
        }
        self.refreshControl = UIRefreshControl()
        self.collectionView.alwaysBounceVertical = true
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.collectionView.addSubview(self.refreshControl)
    }
    
    //MARK: Actions
    
    /// Refresh Control Action
    ///
    /// - Parameter sender: UIRefreshControl object
    @objc func refresh(sender:AnyObject) {
        // Code to refresh collection view
        self.getImageDetail()
    }
}

extension PinterestCollectionViewController{
    
    /// Reload collection view once data is fetched
    func reloadCollectionView() {
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.collectionView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    /// show error received from API
    ///
    /// - Parameter error: APIError
    func setError(error:APIError){
        DispatchQueue.main.async() { () -> Void in
            self.activityStopAnimating()
            self.showAlert(withTitle: "Error", message: error.message)
        }
    }
}
