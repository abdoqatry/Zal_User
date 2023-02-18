//
//  NearStoreModel.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import Foundation

// MARK: - NearStoreModel
struct NearStoreModel: Codable {
    let data: [nearModel]?
    let links: Links?
    let meta: Meta?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct nearModel: Codable {
    let id: Int?
    let name, desc, email: String?
    let image, coverImage: String?
    let phone, address, lat, lng: String?
    let city, area: Area?
    let mainCategory: MainCategory?
    let rate: Int?
    let isVerified: Bool?
    let distance: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, desc, email, image
        case coverImage = "cover_image"
        case phone, address, lat, lng, city, area
        case mainCategory = "main_category"
        case rate
        case isVerified = "is_verified"
        case distance
    }
}


