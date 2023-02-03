//
//  CALayer.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

extension CALayer {
    
    //                                      Apply Shadow to any layer
    //loginBtn.layer.shadowRadius = 8.0
    //loginBtn.layer.cornerRadius = 10.0
    func applySketchShadow(
        color: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 1,
        blur: CGFloat = 2,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    
   
}
