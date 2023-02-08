//
//  UserModel.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let data: Userdata?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct Userdata: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let token: String?
    let isActive, isVerified: Bool?
    let lat, lng, address: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image, token
        case isActive = "is_active"
        case isVerified = "is_verified"
        case lat, lng, address
    }
}
