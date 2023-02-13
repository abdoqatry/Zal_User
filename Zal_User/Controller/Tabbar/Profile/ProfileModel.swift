//
//  ProfileModel.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let data: ProfileData?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct ProfileData: Codable {
    let id: Int?
    let name, email, phone: String?
    let image, coverImage: String?
    let gender, country, city, area: String?
    let length, weight, dateOfBirth: String?
    let token: String?
    let isVerified: Bool?
    let lat, lng, address: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image
        case coverImage = "cover_image"
        case gender, country, city, area, length, weight
        case dateOfBirth = "date_of_birth"
        case token
        case isVerified = "is_verified"
        case lat, lng, address
    }
}
