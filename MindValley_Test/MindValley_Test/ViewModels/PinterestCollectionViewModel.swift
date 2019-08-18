//
//  PinterestCollectionViewModel.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class PinterestCollectionViewModel: NSObject {
    var imageArray:[ImageDetailModel] = []
    
    /// completion handler returning success or APIError object
    typealias LoadImageListCompletionHandler = (Bool, APIError?) -> Void
    
    
    private let fetchRequestManager = ImageDetailFetchManager()
    
    /// Trigger Image Detail List Fetch Request
    func getImageDetailList(completion: @escaping LoadImageListCompletionHandler){
        fetchRequestManager.getImageDetail(from: ImageDetailFetchRequest(), completion:  {[weak self]
            result in
            switch result {
            case .success(let imageList):
                self?.imageArray = imageList ?? []
                completion(true, nil)
                break
            case .failure(let error):
                completion(false, error)
                break
            }
        })
    }
    
    /// Get ImageDetail Object at indexPath
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: ImageDetailModel object
    func imageAtIndexPath(_ indexPath: IndexPath) -> ImageDetailModel? {
        return self.imageArray[indexPath.row]
    }
}

// MARK: UICollectionView DataSource and Delegate
extension PinterestCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    /// Number of sections in collection view
    ///
    /// - Parameter collectionView: Collection view object
    /// - Returns: Int value
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    /// Number of items in the section
    ///
    /// - Parameters:
    ///   - collectionView: Collection view object
    ///   - section: section in which items are added
    /// - Returns: Int value
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    /// Cell configuration for the item
    ///
    /// - Parameters:
    ///   - collectionView: Collection view object
    ///   - indexPath: index at which cell need to be configured
    /// - Returns: CollectionViewCell object
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIdentifierStrings.kImageCollectionReuseIdentifier, for: indexPath) as? PinterestCollectionViewCell else{fatalError("Unable to dequeue cell")}
        
        // Configure the cell
        cell.isAccessibilityElement = true
        
        if let imageDetail = self.imageAtIndexPath(indexPath) {
            cell.imageDetail = imageDetail
        }
        return cell
    }
}

//MARK: - Pinterest Layout Delegate
extension PinterestCollectionViewModel : PinterestLayoutDelegate {
    
    /// Returns the photo height
    ///
    /// - Parameters:
    ///   - collectionView: Collection view object
    ///   - indexPath: index at which cell need to be configured
    /// - Returns: CGSize representing height and width
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
        if let height = self.imageAtIndexPath(indexPath)?.height, let width = self.imageAtIndexPath(indexPath)?.width{
            return CGSize.init(width: width, height: height)
        }
        else{
            return CGSize.init()
        }
    }
    
}
