//
//  contactModel.swift
//  Zal_User
//
//  Created by Admin on 07/11/2023.
//

import Foundation

struct ContactusModel: Codable {
    let mssage: String?
    let status: Int?
}

// MARK: - ContactInfoModel
struct ContactInfoModel: Codable {
    let status, message: String
    let data: infoDataClass?
}

// MARK: - DataClass
struct infoDataClass: Codable {
    let email: String?
    let website: String?
    let appName: String?
    let tiktok, snapchat, facebook, insta: String?
    let youtube, twitter: String?
    let phone: String?
    let offersLink: String?

    enum CodingKeys: String, CodingKey {
        case email
        case website
        case appName = "app_name"
        case tiktok, snapchat, facebook, insta, youtube, twitter, phone
        case offersLink = "offers_link"
    }
}
