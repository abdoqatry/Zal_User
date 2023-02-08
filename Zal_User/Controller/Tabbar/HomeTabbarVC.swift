//
//  HomeTabbarVC.swift
//  Zal_User
//
//  Created by Admin on 08/02/2023.
//

import UIKit

class HomeTabbarVC: UITabBarController,UITabBarControllerDelegate {

    var index = 0
    let fillerView = UIView()
    
    @IBOutlet weak var tabbarView: TabBarC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarButtons()
      
//        let appearance = UITabBarItem.appearance()
//        let attributes = [NSAttributedString.Key.font:UIFont(name: "NeoSansW23".localize, size: 11)]
//        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceived4(_:)), name: NSNotification.Name(rawValue: "UserOpenOrders"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceived(_:)), name: NSNotification.Name(rawValue: "AddMeal"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceived2(_:)), name: NSNotification.Name(rawValue: "ProfileTapped"), object: nil)
        
        delegate = self
        tabBar.tintColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       print("Selected item")
       if tabBar.tag == 1{
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName1"), object: nil)

       }else if tabBar.tag == 5{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName5"), object: nil)
       }else if tabBar.tag == 3{
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UsernotificationMyProduct"), object: nil)
           }
//          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil)
   }
   
   // UITabBarControllerDelegate
      public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
//            tabBar.items?[2].isEnabled = false
          if viewController.tabBarItem.tag == 4 {
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeliveryChat"), object: nil)
          }else if viewController.tabBarItem.tag == 2{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HomeUser2"), object: nil)
       }else if viewController.tabBarItem.tag == 5{
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName5"), object: nil)
       }else if viewController.tabBarItem.tag == 3{
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserProfile"), object: nil)
       }
          
      }
    
    @objc func methodOfReceived(_ notification: NSNotification) {
            self.index = 4
            setupTabBarButtons()
    }
    @objc func methodOfReceived4(_ notification: NSNotification) {
            self.index = 0
            setupTabBarButtons()
    }
    @objc func methodOfReceived2(_ notification: NSNotification) {
            self.index = 1
            setupTabBarButtons()
    }
    
    override func viewWillLayoutSubviews() {
          super.viewWillLayoutSubviews()
      view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
      tabBar.backgroundImage = UIImage.from(color: .green)
                 tabBar.shadowImage = UIImage()
               tabBar.layer.applySketchShadow()
                 fillerView.frame = tabBar.frame
                 fillerView.roundCorners(corners: [.topLeft, .topRight], radius: 40.0)
      fillerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                 view.addSubview(fillerView)
      fillerView.layer.applySketchShadow()
    
        view.bringSubviewToFront(tabBar)

          }
    
    private func setupTabBarButtons() {
     let AddProduct = Bundle.main.loadNibNamed("HomeVC", owner: nil, options: nil)![0] as! HomeVC
    
      let Homevc = Bundle.main.loadNibNamed("HomeVC", owner: nil, options: nil)![0] as! HomeVC
     let ChatVC = Bundle.main.loadNibNamed("HomeVC", owner: nil, options: nil)![0] as! HomeVC
     let More = Bundle.main.loadNibNamed("HomeVC", owner: nil, options: nil)![0] as! HomeVC
   let MyWalletVC = Bundle.main.loadNibNamed("HomeVC", owner: nil, options: nil)![0] as! HomeVC
     
     let addProduct = UINavigationController(rootViewController: AddProduct)
         let home = UINavigationController(rootViewController: Homevc)
         let Chat = UINavigationController(rootViewController: ChatVC)
         let MoreVC = UINavigationController(rootViewController: More)
     let MyWallet = UINavigationController(rootViewController: MyWalletVC)

         
        addProduct.tabBarItem = UITabBarItem(title:"Add Meal".localize, image: UIImage(named: ""), tag: 1)
//            search.tabBarItem = tabOneBarItem
     addProduct.tabBarItem.imageInsets = UIEdgeInsets.init(top: -10,left: 0,bottom: -5,right: 0)
//            search.setViewControllers([tabOne], animated: false)
     
     
//     let barImage: UIImage = UIImage(named:"Group 24443")!.resizedImage(newWidth: 65).roundedImage.withRenderingMode(.alwaysOriginal)
     
     
//     addProduct.tabBarItem = UITabBarItem(title: NSLocalizedString("", comment: ""), image: barImage.withRenderingMode(.alwaysOriginal), selectedImage:barImage)
//
     let modelName = UIDevice.modelName
     if  modelName == "iPhone 8 Plus" || modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "iPhone 8" {
         addProduct.tabBarItem.imageInsets = UIEdgeInsets(top: -15, left: 0, bottom: 15, right: 0)
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0)
     }else{
         if ( UIDevice.current.model.range(of: "iPad") != nil){
             addProduct.tabBarItem.imageInsets = UIEdgeInsets(top: -15, left: 0, bottom: 15, right: 0)
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)

        } else {
         addProduct.tabBarItem.imageInsets = UIEdgeInsets(top: -50, left: 0, bottom: -20, right: 0)
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 5.0)
        }
     }
        home.tabBarItem = UITabBarItem(title: "Home".localize, image: UIImage(named: "shopping-list"), tag: 2)
        Chat.tabBarItem = UITabBarItem(title: "Chat".localize, image:UIImage(named: "chat"), tag: 3)
        MoreVC.tabBarItem = UITabBarItem(title: "More".localize, image:UIImage(named: "Group 24040"), tag: 4)
        MyWallet.tabBarItem = UITabBarItem(title: "Wallet".localize, image:UIImage(named: "Group 24370"), tag: 5)
 
    
     var tabBarList : [ UIViewController]?
//        if AuthService.instance.authToken == nil || AuthService.instance.authToken == "" {
         tabBarList = [
            home,
            Chat,
//            addProduct,
            MyWallet,
            MoreVC,
             ]
//        }else{
//            tabBarList = [
//                MoreVC,
//                MyWallet,
//                addProduct,
//                Chat,
//                home,
//                ]
//        }
     
     
     
         
     viewControllers = tabBarList
        selectedViewController = tabBarList?[index]
//          selectedIndex = index
         
         tabBar.items?.forEach({ (item) in
        item.imageInsets = UIEdgeInsets(top: -8, left: 0, bottom: -4, right: 0)
         })
     }
    
    

}




extension UIDevice {
        var hasNotch: Bool {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        }
    }
    
    

    
class TabBarC:UITabBar {
    
    override func awakeFromNib() {
    super.awakeFromNib()
//        self.barTintColor = UIColor.red
//    self.backgroundImage = UIImage()
//    self.shadowImage = UIImage()

    }
    
   override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 70
        return sizeThatFits
    }
    
override var traitCollection: UITraitCollection {
    guard UIDevice.current.userInterfaceIdiom == .pad else {
        return super.traitCollection
    }

    return UITraitCollection(traitsFrom: [super.traitCollection, UITraitCollection(horizontalSizeClass: .compact)])
}
    
}



extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    func resizedImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


class RoundShadowView: UIView {

    let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutView() {

        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -8.0)
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 10.0
        containerView.layer.cornerRadius = 30
        containerView.layer.masksToBounds = true

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}



public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad12,3", "Simulator iPhone12,3":                    return "iPhone 11 Pro"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

