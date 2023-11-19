//
//  EditOrderModel.swift
//  Zal_User
//
//  Created by Admin on 18/11/2023.
//

import Foundation

// MARK: - EditCartModel
struct EditCartModel: Codable {
    let status, message: String?
    let data: EditDataClass?
}

// MARK: - DataClass
struct EditDataClass: Codable {
    let id, orderNum, status: String?
    let statusTimes: [StatusTime]?
    let payType: String?
//    let transactionID: JSONNull?
    let products: [ProductElement]?
    let provider: Provider?
//    let coupon: JSONNull?
    let isPaid: Bool?
    let distance, productsTotal, delivery, totalBeforeDiscount: Int?
    let discountAmount: Int?
    let tax, vat: Double?
    let appPercent: String?
    let appAmount, providerAmount, subTotal: Int?
    let total: Double?
    let date, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNum = "order_num"
        case status
        case statusTimes = "status_times"
        case payType = "pay_type"
//        case transactionID = "transaction_id"
        case products, provider
        case isPaid = "is_paid"
        case distance
        case productsTotal = "products_total"
        case delivery
        case totalBeforeDiscount = "total_before_discount"
        case discountAmount = "discount_amount"
        case tax, vat
        case appPercent = "app_percent"
        case appAmount = "app_amount"
        case providerAmount = "provider_amount"
        case subTotal = "sub_total"
        case total, date
        case createdAt = "created_at"
    }
}
//
//// MARK: - ProductElement
//struct ProductElement: Codable {
//    let id: String?
//    let product: ProductProduct?
//    let quantity, price: Int?
//}
//
//// MARK: - ProductProduct
//struct ProductProduct: Codable {
//    let id: Int?
//    let image: String?
//    let name: String?
//    let price, description: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, image, name
//        case price, description
//    }
//}
//
//// MARK: - Provider
//struct Provider: Codable {
//    let id: Int?
//    let name, desc, terms: String?
//    let image: String?
//    let createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, desc, terms, image
//        case createdAt = "created_at"
//    }
//}
