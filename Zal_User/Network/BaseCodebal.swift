//
//  BaseCodebal.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//


import Foundation


protocol BaseCodable: Codable {
    var actionName: String? { get set }
    var FailRes: String? { get set }
}


func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    } else {
        // Fallback on earlier versions
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    } else {
        // Fallback on earlier versions
    }
    return encoder
}


