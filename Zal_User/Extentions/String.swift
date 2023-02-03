//
//  String.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit


extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func trunc(length: Int, trailing: String = "…") -> String {
      return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
    var trimmedString: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var filterAsURL: String {
        return self.replacingOccurrences(of: "\\", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var localize: String {
        return NSLocalizedString(self, comment: "Hello From String Extension")
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension Bool {
    var toInt: Int {
        return NSNumber(booleanLiteral: self).intValue
    }
}

extension NSMutableAttributedString {
    
    func setupAttriutedLable(texts: [String], fonts: [UIFont], colors: [UIColor]) -> NSAttributedString {
        // multi line enable
        //* planOne.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let output = NSMutableAttributedString.init(string: texts.first?.localize ?? "", attributes: [.foregroundColor: colors.first ?? .black, .font: fonts.first ?? .systemFont(ofSize: 10), .paragraphStyle: paragraphStyle])
        guard texts.count > 1, texts.count == fonts.count, texts.count == colors.count else { return output }
        for index in texts.indices.dropFirst() {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index], .font: fonts[index], .paragraphStyle: paragraphStyle]
            output.append(NSAttributedString(string: texts[index].localize, attributes: attributes))
        }
        return output
    }
    
    convenience init(texts: [String], fonts: [UIFont], colors: [UIColor],_ alignment: NSTextAlignment = .center) {
        //* planOne.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        self.init(string: texts.first ?? "", attributes: [.foregroundColor: colors.first ?? .black, .font: fonts.first ?? .systemFont(ofSize: 10), .paragraphStyle: paragraphStyle])
        
        if texts.count > 1 && texts.count == fonts.count && texts.count == colors.count {
            for index in texts.indices.dropFirst() {
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index], .font: fonts[index], .paragraphStyle: paragraphStyle]
                self.append(NSAttributedString(string: texts[index], attributes: attributes))
            }
        }
    }
}


extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
//              if Bundle.currentAppleLanguage()  == "en" {
//                       style.alignment = .left
//                    }else{
                       style.alignment = .center
//                    }
            
           
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }

}




extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


extension String {
    func makeHTMLfriendly() -> String {
        var finalString = ""
        for char in self {
            for scalar in String(char).unicodeScalars {
                finalString.append("&#\(scalar.value)")
            }
        }
        return finalString
    }
}


