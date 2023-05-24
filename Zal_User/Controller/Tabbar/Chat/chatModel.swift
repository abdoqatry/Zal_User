//
//  chatModel.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import Foundation

// MARK: - MessageListModel
struct MessageListModel: Codable {
    let data: [listMessageDatum]?
    let links: Links?
    let meta: Meta?
    let status: String?
    let message: String?
}

// MARK: - Datum
struct listMessageDatum: Codable {
    let id: String?
    let order: Order2?
    let user: User3?
    let provider: Provider2?
    let lastMsg, msgType, readAt, senderType: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, order, user, provider
        case lastMsg = "last_msg"
        case msgType = "msg_type"
        case readAt = "read_at"
        case senderType = "sender_type"
        case createdAt = "created_at"
    }
}


// MARK: - Provider
struct Provider2: Codable {
    let id: Int?
    let name, desc: String?
    let image: String?
    let address: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, desc, image, address
        case createdAt = "created_at"
    }
}

// MARK: - User
struct User3: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
}

// MARK: - Order
struct Order2: Codable {
    let id, orderNum, status, payType: String?
//    let transactionID: st?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNum = "order_num"
        case status
        case payType = "pay_type"
//        case transactionID = "transaction_id"
        case createdAt = "created_at"
    }
}
