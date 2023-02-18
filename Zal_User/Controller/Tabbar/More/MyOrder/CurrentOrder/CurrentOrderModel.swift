//
//  CurrentOrderModel.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import Foundation

// MARK: - CurrentOrderModel
struct CurrentOrderModel: Codable {
    let data: [CurrentOrderDatum]?
    let links: Links?
    let meta: Meta?
    let status, message: String?
}

// MARK: - Datum
struct CurrentOrderDatum: Codable {
    let id, orderNum: String?
    let status: String?
    let statusTimes: [StatusTime]?
    let payType: PayType?
    let transactionID: String?
    let products: [ProductElement]?
    let provider: ProviderCurrent?
    let coupon: Coupon?
    let distance, productsTotal, delivery: Int?
    let totalBeforeDiscount: Double?
    let discountAmount: Int?
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

// MARK: - Coupon
struct Coupon: Codable {
    let id: Int?
    let name, code, discountType: String?
    let discount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case discountType = "discount_type"
        case discount
    }
}

enum PayType: String, Codable {
    case cash = "cash"
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: String?
    let product: ProductProduct?
    let quantity, price: Int?
}

// MARK: - ProductProduct
struct ProductProduct: Codable {
    let id: Int?
    let image: String?
    let name: String?
    let nameEn: String?
    let price, description: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case nameEn = "name_en"
        case price, description
    }
}

// MARK: - Provider
struct ProviderCurrent: Codable {
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

//enum Status: String, Codable {
//    case accept = "accept"
//    case pending = "pending"
//    case refuse = "refuse"
//}

// MARK: - StatusTime
struct StatusTime: Codable {
    let pending, refuse, accept: String?
}

// MARK: - Links
struct Links: Codable {
    let first, last: String?
    let prev: String?
    let next: String?
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage: Int?
    let links: [Link]?
    let path: String?
    let perPage, to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case links, path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}
