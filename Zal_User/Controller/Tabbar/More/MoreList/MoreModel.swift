//
//  MoreModel.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import Foundation


class dummyItem :NSObject
{
    var name: String = ""
    var image:  String = ""

    init(name: String, image:String) {
        self.name = name
        self.image = image
    }

    init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.image = decoder.decodeObject(forKey: "image") as! String
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.image, forKey: "image")
    }
}
