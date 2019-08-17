//
//  PinterestCollectionViewCell.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {
    lazy var textBackgroundView: UIView = {
        let view = UIView()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var imageDetail: ImageDetailModel! {
        didSet {
            self.imageView.image = UIImage.init(named: "NoImageAvailable")
            if let nameString = imageDetail?.user?.name{
                nameLabel.text = nameString
            }
            if let likesCount = imageDetail?.likes{
                likesLabel.text = String.init(format: "\(likesCount)👍")
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        NSLayoutConstraint.activate([
            
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            textBackgroundView.heightAnchor.constraint(equalToConstant: 35.0),
            textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4.0),
            
            likesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2.0),
            
            likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4.0),
            likesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0),
            
            
            ])
        imageView.isAccessibilityElement = true
        imageView.accessibilityIdentifier = "ImageView"
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
