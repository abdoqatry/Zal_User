//
//  UIViewController.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//


import UIKit
import DKImagePickerController
import Photos
import SwiftUI

extension UIViewController {
    

    func showAlert(title : String, messages : [String]?, message: String?, selfDismissing: Bool) {

        var messageContent = ""

        if let messages = messages {
            for message in messages {
                messageContent += message + "\n"
            }
        }

        if let message = message {
            messageContent = message
        }

        let alert = UIAlertController(title: title, message: messageContent, preferredStyle: .alert)


        if !selfDismissing {
            let title = NSLocalizedString("موافق", comment: "Any")
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        }
        present(alert, animated: true)

        if selfDismissing {
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                alert.dismiss(animated: true)
            } }
    }
    
    func linedBt(Button: UIButton,tittle:String, color : UIColor){
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 15),
              .foregroundColor: color ,
              .underlineStyle: NSUnderlineStyle.single.rawValue]
    let attributeString = NSMutableAttributedString(string: tittle,attributes: yourAttributes)
        Button.setAttributedTitle(attributeString, for: .normal)
    }
    
    func getCurrentDeviceLanguage() -> String {
        if let langStr = Locale.current.languageCode {
            return langStr
        }
        return "en"
    }
    
    func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
    
    func converttime(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "HH:mm"
            return  dateFormatter.string(from: date!)

        }
    
    func convertdateformate(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)

        }
    
//    func setupNavigationBar() {
//      
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.configureWithOpaqueBackground()
//        navigationBarAppearance.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor : UIColor.white
//        ]
//        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
//        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
//        navigationBarAppearance.shadowColor = .clear
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
//        
//UINavigationBar.appearance().tintColor = UIColor.white
//
//       }
    
    func setupNavigationBar() {
      
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.shadowColor = .clear
        
UINavigationBar.appearance().tintColor = UIColor.white
        

       }
    
    func setNavigationLeftBT(){
        let button1 = UIBarButtonItem(image: UIImage(named:"Group 24032")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(bell))
        navigationItem.setLeftBarButtonItems([button1], animated: true)
    }
    
    @objc func bell(){
        let vc = Bundle.main.loadNibNamed("CartVC", owner: nil, options: nil)![0] as! CartVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

