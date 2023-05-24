//
//  ChatModel.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import Foundation

// MARK: - ChatModel
struct ChatModel: Codable {
    let data: ChatData?
//    let status: String?
    let message: String?
}

// MARK: - DataClass
struct ChatData: Codable {
    let id: String?
    let order: Order4?
    let user: User4?
    let provider: Provider4?
    let messages: [Message]?
    let lastMsg, msgType, readAt, senderType: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, order, user, provider, messages
        case lastMsg = "last_msg"
        case msgType = "msg_type"
        case readAt = "read_at"
        case senderType = "sender_type"
        case createdAt = "created_at"
    }
}

// MARK: - Message
struct Message: Codable {
    let id: String?
    let msg: String?
    let msgType, senderType, readAt, createdAt: String?
    let sending: Bool?

    enum CodingKeys: String, CodingKey {
        case id, msg,sending
        case msgType = "msg_type"
        case senderType = "sender_type"
        case readAt = "read_at"
        case createdAt = "created_at"
    }
}

// MARK: - Order
struct Order4: Codable {
    let id, orderNum, status, payType: String?
    let transactionID: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNum = "order_num"
        case status
        case payType = "pay_type"
        case transactionID = "transaction_id"
        case createdAt = "created_at"
    }
}

// MARK: - Provider
struct Provider4: Codable {
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
struct User4: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
}
