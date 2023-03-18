//
//  CartModel.swift
//  Zal_User
//
//  Created by Admin on 18/03/2023.
//

import Foundation

// MARK: - CartModel
struct CartModel: Codable {
    let status, message: String?
    let data: CartData?
}

// MARK: - DataClass
struct CartData: Codable {
    let id: String?
    let products: [ProductElement]?
    let provider: Provider?
    let coupon: String?
    let productsTotal, delivery: Int?
    let totalBeforeDiscount: Double?
    let discountAmount: Int?
    let vat, total: Double?

    enum CodingKeys: String, CodingKey {
        case id, products, provider, coupon
        case productsTotal = "products_total"
        case delivery
        case totalBeforeDiscount = "total_before_discount"
        case discountAmount = "discount_amount"
        case vat, total
    }
}
