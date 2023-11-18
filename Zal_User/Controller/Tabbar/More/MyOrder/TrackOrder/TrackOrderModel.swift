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
    let vat, appAmount, providerAmount, total,tax: Double?
    let date, createdAt: String?
    let address: addressModel?
    let is_paid : Bool?

    enum CodingKeys: String, CodingKey {
        case id,is_paid,address,tax
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

struct addressModel : Codable {
    let location : String?
    let desc : String?
    let name : String?
    let lng : String?
    let lat : String?
}



// MARK: - PaymentChickModel
struct PaymentChickModel: Codable {
//    let status: String?
    let data: CheckPaymentClass?
    let message: String?
}

// MARK: - DataClass
struct CheckPaymentClass: Codable {
    let result: Result?
    let buildNumber, timestamp, ndc: String?
}


// MARK: - GetHyperPay
struct GetHyperPayModel: Codable {
    let status: String?
    let data: PaymentDataClass?
    let message: String?
    let msg: Msg?
}

// MARK: - DataClass
struct PaymentDataClass: Codable {
    let checkoutID: String?

    enum CodingKeys: String, CodingKey {
        case checkoutID = "checkout_id"
    }
}

// MARK: - Msg
struct Msg: Codable {
    let result: Result?
    let buildNumber, timestamp, ndc, id: String?
}

// MARK: - Result
struct Result: Codable {
    let code, description: String?
}


// MARK: - ChargeModel
struct ChargeModel: Codable {
    let status: String?
    let message: String?
}
