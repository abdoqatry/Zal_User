//
//  AddressListModel.swift
//  Zal_User
//
//  Created by Admin on 11/03/2023.
//

import Foundation

// MARK: - AddressListModel
struct AddressListModel: Codable {
    let data: [AdressDatum]?
//    let status: String?
    let message: String?
}

// MARK: - Datum
struct AdressDatum: Codable {
    let id: Int?
    let lat, lng, location, name: String?
    let nameEn, desc: String?
    let code : String?

    enum CodingKeys: String, CodingKey {
        case id, lat, lng, location, name
        case nameEn = "name_en"
        case desc,code
    }
}


// MARK: - AddressModel
struct AddressModel: Codable {
    let data: AddressDataClass?
    let status, message: String?
}

// MARK: - DataClass
struct AddressDataClass: Codable {
    let id: Int?
    let lat, lng, location, name: String?
    let nameEn, desc: String?

    enum CodingKeys: String, CodingKey {
        case id, lat, lng, location, name
        case nameEn = "name_en"
        case desc
    }
}
