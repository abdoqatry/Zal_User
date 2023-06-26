//
//  TrackOrderModel.swift
//  Zal_User
//
//  Created by Admin on 20/02/2023.
//

import Foundation

// MARK: - OrdersDtailsModel
struct OrdersDtailsModel: Codable {
    let data: OrderDetailsClass?
    let status, message: String?
}

// MARK: - DataClass
struct OrderDetailsClass: Codable {
    let id, orderNum, status: String?
    let statusTimes: [StatusTime]?
    let payType: String?
    let transactionID: String?
    let products: [ProductElement]?
    let provider: Provider?
    let coupon: Coupon?
    let distance, productsTotal, delivery: Double?
    let totalBeforeDiscount: Double?
    let discountAmount: Double?
    let vat, appAmount, providerAmount, total: Double?
    let date, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNum = "order_num"
        case status
        case statusTimes = "status_times"
        case payType = "pay_type"
        case transactionID = "transaction_id"
        case products, provider, coupon, distance
        case productsTotal = "products_total"
        case delivery
        case totalBeforeDiscount = "total_before_discount"
        case discountAmount = "discount_amount"
        case vat
        case appAmount = "app_amount"
        case providerAmount = "provider_amount"
        case total, date
        case createdAt = "created_at"
    }
}

//// MARK: - Coupon
//struct Coupon: Codable {
//    let id: Int?
//    let name, code, discountType: String?
//    let discount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, code
//        case discountType = "discount_type"
//        case discount
//    }
//}

// MARK: - ProductElement
//struct ProductElement: Codable {
//    let id: String?
//    let product: ProductProduct?
//    let quantity, price: Int?
//}

// MARK: - ProductProduct
//struct ProductProduct: Codable {
//    let id: Int?
//    let image: String?
//    let name: String?
//    let nameEn: String?
//    let price, description: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, image, name
//        case nameEn = "name_en"
//        case price, description
//    }
//}

// MARK: - Provider
//struct Provider: Codable {
//    let id: Int?
//    let name, desc: String?
//    let image: String?
//    let address: String?
//    let createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, desc, image, address
//        case createdAt = "created_at"
//    }
//}

// MARK: - StatusTime
//struct StatusTime: Codable {
//    let pending: String?
//}
