//
//  UiRespond.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit
import RappleProgressHUD

extension UIResponder {
    
    func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        return nil
    }
    
    func present(viewController: UIViewController) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        getTopViewController()!.present(viewController, animated: true, completion: nil)
    }
    
    func presentPop(viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        getTopViewController()!.present(viewController, animated: true, completion: completion)
    }
    
    func openIndicator(title: String, description: String) {
          print("++++++++++++++++indicator opend")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.circle,
                                                               tintColor: .black,
                                                               screenBG: .clear,
                                                               progressBG: .clear,
                                                               progressBarBG: .clear,
                                                               progreeBarFill: .clear,
                                                               thickness: 0.5)
        RappleActivityIndicatorView.startAnimatingWithLabel("", attributes: attributes)
        
    }
    
    func closeIndicator() {
        print("--------------indicator closed")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        RappleActivityIndicatorView.stopAnimation()
        //         RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Completed.", completionTimeout: 0.1)
    }

}




extension UIView {
    
   func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}





