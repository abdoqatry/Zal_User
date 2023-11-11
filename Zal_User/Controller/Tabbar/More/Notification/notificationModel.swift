//
//  notificationModel.swift
//  Zal_User
//
//  Created by Admin on 11/11/2023.
//

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Codable {
    let data: [notifictionDatum]?
    let links: Links?
    let meta: Meta?
    let status, message: String?
}

// MARK: - Datum
struct notifictionDatum: Codable {
    let id: String?
    let title: String?
    let body : String?
    let notifyType: String?
    let createdAt: String?
    let readAt: String?
    let image: String?
    let userID: Int?
    let orderID: String?

    enum CodingKeys: String, CodingKey {
        case id, title,body
        case notifyType = "notify_type"
        case createdAt = "created_at"
        case readAt = "read_at"
        case image
        case userID = "user_id"
        case orderID = "order_id"
    }
}
