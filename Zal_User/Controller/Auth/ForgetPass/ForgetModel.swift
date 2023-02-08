//
//  ForgetModel.swift
//  Zal_User
//
//  Created by Admin on 04/02/2023.
//

import Foundation

// MARK: - ForgetPassModel
struct ForgetPassModel: Codable {
    let data: String?
    let message: String?
    let status: Int?
}

struct CheckPassModel: Codable {
    let data: Bool?
    let message: String?
    let status: Int?
}
