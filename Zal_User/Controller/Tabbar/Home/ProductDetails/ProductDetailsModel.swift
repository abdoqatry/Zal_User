//
//  ProductDetailsModel.swift
//  Zal_User
//
//  Created by Admin on 02/03/2023.
//

import Foundation

// MARK: - ProductDetailsModel
struct ProductDetailsModel: Codable {
    let data: ProductDetailsData?
//    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct ProductDetailsData: Codable {
    let id: Int?
    let name, price: String?
    let hasOffer: Bool?
    let priceOffer, description: String?
    let locked: Bool?
    let rate: Int?
    let category: Category?
    let images: [Image]?
    let isLiked: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case hasOffer = "has_offer"
        case priceOffer = "price_offer"
        case description, locked, rate, category, images
        case isLiked = "is_liked"
    }
}
//
//// MARK: - Category
//struct Category: Codable {
//    let id: Int?
//    let image: String?
//    let isActive: Int?
//    let parentID: JSONNull?
//    let createdAt, updatedAt, name: String?
//    let desc: JSONNull?
//    let slug: String?
//    let translations: [Translation]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, image
//        case isActive = "is_active"
//        case parentID = "parent_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case name, desc, slug, translations
//    }
//}
//
//// MARK: - Translation
//struct Translation: Codable {
//    let id, categoryID: Int?
//    let name: String?
//    let desc: JSONNull?
//    let slug, locale: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case categoryID = "category_id"
//        case name, desc, slug, locale
//    }
//}
