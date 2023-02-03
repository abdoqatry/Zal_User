//
//  AppDelegate.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 15, *) {
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
                    
                    let tabBarApperance = UITabBarAppearance()
//                    tabBarApperance.configureWithOpaqueBackground()
//                    tabBarApperance.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
                    UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
//                    UITabBar.appearance().standardAppearance = tabBarApperance
         
            UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
                }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC

        let Login = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = Login
        return true
    }




}

