//
//  HomeModel.swift
//  Zal_User
//
//  Created by Admin on 08/02/2023.
//

import Foundation

// MARK: - SliderModel
struct SliderModel: Codable {
    let data: [sliderModel]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct sliderModel: Codable {
    let id: Int?
    let image: String?
    let name, desc: String?
    let providerID: Int?

    enum CodingKeys: String, CodingKey {
        case id, image, name, desc
        case providerID = "provider_id"
    }
}


// MARK: - SliderModel
struct HomeModel: Codable {
    let data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    let mostRatedProviders, nearestProviders: [Provider]?
    let cartCount: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case mostRatedProviders = "most_rated_providers"
        case nearestProviders = "nearest_providers"
        case cartCount = "cart_count"
        case message
    }
}

// MARK: - Provider
struct Provider: Codable {
    let id: Int?
    let name, desc, email: String?
    let image, coverImage: String?
    let phone, address, lat, lng: String?
    let city, area: Area?
    let mainCategory: MainCategory?
    let rate: Int?
    let isVerified: Bool?
    let distance: Int?

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

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name: String?
}

// MARK: - MainCategory
struct MainCategory: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
