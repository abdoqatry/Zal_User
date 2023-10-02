//
//  servicesModel.swift
//  Zal_User
//
//  Created by Admin on 03/10/2023.
//

import Foundation

// MARK: - ServicesOrderModel
struct ServicesOrderModel: Codable {
    let data: DataservicesModel?
    let message: String?
}

// MARK: - DataClass
struct DataservicesModel: Codable {
    let id: Int?
    let day, time, desc, status: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, day, time, desc, status
        case createdAt = "created_at"
    }
}
