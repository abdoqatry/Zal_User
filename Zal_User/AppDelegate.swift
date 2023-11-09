//
//  AppDelegate.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let googleKey = "AIzaSyBVRc85zEOrgFDOxGWMpBCG3Xjm7Q4jWQk"
        
        FirebaseApp.configure()
        registerForPushNotifications(application: application) // access permission
        Messaging.messaging().delegate = self
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        if #available(iOS 15, *) {
                        let navigationBarAppearance = UINavigationBarAppearance()
                        navigationBarAppearance.configureWithOpaqueBackground()
                        navigationBarAppearance.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor : UIColor.white
                        ]
           
            navigationBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8980392157)
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
        GMSServices.provideAPIKey(googleKey)
        GMSPlacesClient.provideAPIKey(googleKey)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
                }
        
        let vc = Bundle.main.loadNibNamed("IntroFirstPageVC", owner: nil, options: nil)![0] as! IntroFirstPageVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC

        let Login = UINavigationController(rootViewController: vc)
        
        if AuthService.instance.authToken == nil || AuthService.instance.authToken == "" {
            window?.rootViewController = Login

        }else{
        window?.rootViewController = HomeTabbarVC()
        }

        return true
    }



    func registerForPushNotifications(application: UIApplication){
        
            UNUserNotificationCenter.current() // 1
                .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                    granted, error in
                    print("Permission granted: \(granted)") // 3
                    if granted{
                        DispatchQueue.main.async{
                            application.registerForRemoteNotifications()
                        }
                    }else{
                        print("user notification permission denied:\(String(describing: (error?.localizedDescription)))")
                    }
            }
            UNUserNotificationCenter.current().delegate = self
        }


}


extension AppDelegate: UNUserNotificationCenterDelegate{
    //Method: 1 - will register app on apps to receive token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Succeful registeration token is \(deviceToken) ")
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)}) // device token will passed to backend
        print("Succeful registeration token is \(deviceTokenString) ")
        Messaging.messaging().apnsToken = deviceToken
        //Production
        Messaging.messaging().setAPNSToken(deviceToken as Data, type: .prod)
        //        InstanceID.instanceID().setAPNSToken(
        //            deviceToken as Data,
        //            type:.p)
        
        //  Auth.auth().setAPNSToken(deviceToken, type: .prod)
        
        
    }
    //Method : 2 failed to registeration
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notification : \(error.localizedDescription)")
    }
    
    //Method : 3 - In this method app will receive notifications in [userInfo]
    //    When your app is in the background, iOS directs messages with the notification key to the system tray. A tap on a notification opens the app, and the content of the notification is passed to the didReceiveRemoteNotification callback in the AppDelegate.
    //get Notification Here below ios 10
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("receive remote notification")
        
        // Print message ID.
        print(userInfo)
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print("Got the msg...")
        completionHandler([.badge, .sound, .alert])
        
    }
    // This function will be called right after user tap on the notification
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        print(userInfo)
        print("\(UIApplication.shared.applicationState)")
        
        if let user = userInfo["aps"] {
            let users = user as! NSDictionary
            
            let type = userInfo["notify_type"] as? String
            //            print(type)
            print(users["alert"]!)
            
            if type == "1" || type == "2"{
                guard let id = userInfo["order_id"]  else {return}
                AuthService.instance.id = id as? String
//                window?.rootViewController = StoreTabbarVC()
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        // Put your code which should be executed with a delay here
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserOpenOrdersDetails"), object: nil)
                    }
                }
                
                
            }else if type == "3" {
//                let vc = Bundle.main.loadNibNamed("HoldePageVC", owner: nil, options: nil)![0] as! HoldePageVC
//                let holdepage = UINavigationController(rootViewController: vc)
//                window?.rootViewController = holdepage
            }
            //        UIApplication.shared.applicationIconBadgeNumber = 0
            // }
            
            // tell the app that we have finished processing the user’s action / response
            completionHandler()
        }
        
    }
    
}

extension AppDelegate:MessagingDelegate{
    // Receive data message on iOS 10 devices.
    func application(received remoteMessage: MessagingDelegate) {
        print("%@", remoteMessage.description)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // Convert token to string
        //        let deviceTokenString = fcmToken.reduce("", {$0 + String(format: "%02X", $1)}) // device token will passed to backend
        AuthService.instance.SetFemToken(fem: fcmToken ?? "")
        print("fcmToken\(fcmToken)")
        
        print("Firebase registration token: \(fcmToken)")
        
    }
}


extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.barTintColor = UIColor.white
    }
}
