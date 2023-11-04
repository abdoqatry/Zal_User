//
//  StoreModel.swift
//  Zal_User
//
//  Created by Admin on 27/02/2023.
//

import Foundation

// MARK: - StoreModel
struct StoreModel: Codable {
    let data: StoreData?
//    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct StoreData: Codable {
    let id: Int?
    let name, desc, email: String?
    let image, coverImage: String?
    let phone, address, lat, lng: String?
    let city, area: Area?
    let mainCategory: MainCategory?
    let rate: Int?
    let isVerified,is_open: Bool?
    let distance: Int?
    let from,to: String?

    enum CodingKeys: String, CodingKey {
        case id, name, desc, email, image,is_open,from,to
        case coverImage = "cover_image"
        case phone, address, lat, lng, city, area
        case mainCategory = "main_category"
        case rate
        case isVerified = "is_verified"
        case distance
    }
}

// MARK: - CategoryModel
struct CategoryModel: Codable {
    let data: [CatDataModel]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct CatDataModel: Codable {
    let id: Int?
    let name: String?
    let image: String?
}

import Foundation

// MARK: - ProductsModel
struct ProductsModel: Codable {
    let data: [productsModel]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct productsModel: Codable {
    let id: Int?
    let name, price: String?
    let hasOffer: Bool?
    let priceOffer: String?
    let description: String?
    let locked: Bool?
    let rate: Double?
    let category: Category?
    let images: [Image]?
    let is_liked : Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, price,is_liked
        case hasOffer = "has_offer"
        case priceOffer = "price_offer"
        case description, locked, rate, category, images
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let image: String?
    let isActive: Int?
    let parentID: String?
    let createdAt, updatedAt, name: String?
    let desc: String?
    let slug: String?
    let translations: [Translation]?

    enum CodingKeys: String, CodingKey {
        case id, image
        case isActive = "is_active"
        case parentID = "parent_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name, desc, slug, translations
    }
}

// MARK: - Translation
struct Translation: Codable {
    let id, categoryID: Int?
    let name: String?
    let desc: String?
    let slug, locale: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case name, desc, slug, locale
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let image: String?
}


// MARK: - FavoriteModel
struct FavoriteModel: Codable {
//    let status: String?
    let data: FavoriteDataClass?
    let message: String?
}

// MARK: - DataClass
struct FavoriteDataClass: Codable {
    let likeStatus: Bool?

    enum CodingKeys: String, CodingKey {
        case likeStatus = "like_status"
    }
}

