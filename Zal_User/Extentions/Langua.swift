//
//  Langua.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation
//import MOLH


var bundleKey: UInt8 = 0
private let APPLE_LANGUAGE_KEY = "AppleLanguages"

class AnyLanguageBundle: Bundle {

override func localizedString(forKey key: String,
                              value: String?,
                              table tableName: String?) -> String {

    guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
        let bundle = Bundle(path: path) else {

            return super.localizedString(forKey: key, value: value, table: tableName)
    }

    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

extension Bundle {

class func setLanguage(_ language: String) {

    defer {

        object_setClass(Bundle.main, AnyLanguageBundle.self)
    }

    objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
    
     class func currentAppleLanguage() -> String {
          let userdef = UserDefaults.standard
          let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
          let current = langArray.firstObject as! String
          let endIndex = current.index(current.startIndex, offsetBy: 2)
          let currentWithoutLocale = current[current.startIndex..<endIndex]
         userdef.synchronize()
          return String(currentWithoutLocale)
      }
    
     class func setAppleLAnguageTo(_ lang: String) {
          let userdef = UserDefaults.standard
          userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
          userdef.synchronize()
      }
}

