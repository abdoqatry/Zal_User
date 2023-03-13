//
//  FavoriteModel.swift
//  Zal_User
//
//  Created by Admin on 12/03/2023.
//

import Foundation

// MARK: - FavoritesModel
struct FavoritesModel: Codable {
    let data: [FavoriteDatum]?
//    let status
    let message: String?
}

// MARK: - Datum
struct FavoriteDatum: Codable {
    let id: Int?
    let name, price: String?
    let hasOffer: Bool?
    let priceOffer: String?
    let description: String?
    let locked: Bool?
    let rate: Double?
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
