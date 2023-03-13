//
//  RateModel.swift
//  Zal_User
//
//  Created by Admin on 02/03/2023.
//

import Foundation

// MARK: - RateModel
struct RateModel: Codable {
    let data: [RateDatum]?
//    let status
    let message: String?
}

// MARK: - Datum
struct RateDatum: Codable {
    let id: Int?
    let user: User2?
    let rate: Double?
    let review: String?
}

// MARK: - User
struct User2: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
}
