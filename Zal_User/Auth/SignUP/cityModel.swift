//
//  cityModel.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation

// MARK: - CityModel
struct CityModel: Codable {
    let data: [Citi]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct Cities: Codable {
    let id: Int?
    let name: String?
    let code : String?
    let image : String?
}

// MARK: - Datum
struct Citi: Codable {
    let id: Int?
    let name: String?
    let code : String?
    let image : String?
}
