//
//  PaymentModel.swift
//  Zal_User
//
//  Created by Admin on 29/03/2023.
//

import Foundation


class PaymentItem :NSObject
{
    var name: String = ""
    var id:  String = ""
    var code : String = ""

    init(name: String, id:String,code:String) {
        self.name = name
        self.id = id
        self.code = code
    }

    init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.id = decoder.decodeObject(forKey: "id") as! String
        self.code = decoder.decodeObject(forKey: "code") as! String
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.id, forKey: "id")
        coder.encode(self.code, forKey: "code")
    }
}




// MARK: - CheckoutModel
struct CheckoutModel: Codable {
    let data: CheckoutData1?
    let status, message: String?
}

// MARK: - DataClass
struct CheckoutData1: Codable {
    let id, orderNum: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNum = "order_num"
        
    }
}
