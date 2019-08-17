//
//  ImageDetailModel.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 18/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

/// Image Detail Model
class ImageDetailModel: Decodable{
    var id: String?
    var createdAt: Date?
    var width: Int?
    var height: Int?
    var color: UIColor?
    var likes: Int?
    var likedByUser:Bool?
    var user:UserDetailModel?
    var currentUserCollections: [String]?
    var urls: [String : String]?
    var categories:[CategoryDetailModel]?
    var links:[String:String]?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case user = "user"
        case currentUserCollections = "current_user_collections"
        case urls = "urls"
        case categories = "categories"
        case links = "links"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.likes = try container.decode(Int.self, forKey: .likes)
        self.likedByUser = try container.decode(Bool.self, forKey: .likedByUser)
        self.user = try container.decode(UserDetailModel.self, forKey: .user)
        self.currentUserCollections = try container.decode(Array.self, forKey: .currentUserCollections)
        self.urls = try container.decode([String:String].self, forKey: .urls)
        self.categories = try container.decode([CategoryDetailModel].self, forKey: .categories)
        self.links = try container.decode([String:String].self, forKey: .links)
        
        
        
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //2016-05-29T15:42:02-04:00
        let dateString = try container.decode(String.self, forKey: .createdAt)
        if let date = dateFormatter.date(from: dateString) {
            self.createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
        
        let colorString = try container.decode(String.self, forKey: .color)
        if let color = UIColor.init(hex: colorString) {
            self.color = color
        } else {
            throw DecodingError.dataCorruptedError(forKey: .color,
                                                   in: container,
                                                   debugDescription: "Color string gives an error")
        }
    }
}

/// Category Detail Model
struct CategoryDetailModel: Decodable{
    var id: Int?
    var title: String?
    var photoCount: Int?
    var links:[String:String]?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case photoCount = "photo_count"
        case links = "links"
    }
}

/// User Detail Model
struct UserDetailModel: Decodable{
    var id: String?
    var username: String?
    var name: String?
    var profileImage:[String:String]?
    var links:[String:String]?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case profileImage = "profile_image"
        case links = "links"
    }
}
