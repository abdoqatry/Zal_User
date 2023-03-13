//
//  AuthServisces.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

class AuthService {

static let instance = AuthService()
private init () { }

    private lazy var ApiTokenKey = "apiToken"
    private lazy var FCMToken = "FcmToken"
     lazy var UserID = "userType"
    private lazy var MobileNumber = "mobileNumber"
    private lazy var UserName = "userName"
   private lazy var userTypeReadable = "user_type_readable"
    private lazy var photo = "userPhoto"
    private lazy var city = "userCity"
    private lazy var cityId = "userCityid"
    private lazy var isconfirm = "confirmed"
     private lazy var isactive = "active"
     private lazy var userAge = "age"
    private lazy var userMail = "mail"
     private lazy var Langua = "langua"
    private lazy var tapped = "Tapped"
    private lazy var verify = "verify"

    private let defaults = UserDefaults.standard
    
    var Languetoked = false

    var Verifyat: Bool? {
             get {
                 return defaults.value(forKey: verify) as? Bool
             }
             set {
                 defaults.set(newValue, forKey: verify)
             }
         }
 
    var id : String? {
            get {
                return defaults.value(forKey: "id") as? String
            }
            set {
                defaults.set(newValue, forKey: "id")
            }
        }
   
      var TappedViews: Int? {
              get {
                  return defaults.value(forKey: tapped) as? Int
              }
              set {
                  defaults.set(newValue, forKey: tapped)
              }
          }
    
      var AppLanguae: Bool? {
             get {
                 return defaults.value(forKey: Langua) as? Bool
             }
             set {
                 defaults.set(newValue, forKey: Langua)
             }
         }

      var authToken: String? {
          get {
              return defaults.value(forKey: ApiTokenKey) as? String
          }
          set {
              defaults.set(newValue, forKey: ApiTokenKey)
          }
      }
    
    var fcmToken: String? {
        get {
            return defaults.value(forKey: FCMToken) as? String
        }
        set {
            defaults.set(newValue, forKey: FCMToken)
        }
    }
    
  
      var username: String? {
          get {
              return defaults.value(forKey: UserName) as? String
          }
          set {
              defaults.set(newValue, forKey: UserName)
          }
      }
    var userAddress: String? {
        get {
            return defaults.value(forKey: "Useraddress") as? String
        }
        set {
            defaults.set(newValue, forKey: "Useraddress")
        }
    }
    var lattitude: String? {
        get {
            return defaults.value(forKey: "lat") as? String
        }
        set {
            defaults.set(newValue, forKey: "lat")
        }
    }
    var lantitude: String? {
        get {
            return defaults.value(forKey: "lan") as? String
        }
        set {
            defaults.set(newValue, forKey: "lan")
        }
    }
        var UserMail: String? {
            get {
                return defaults.value(forKey: userMail) as? String
            }
            set {
                defaults.set(newValue, forKey: userMail)
            }
        }
    
  
      
  


//    func SetUserDefaults(user:UserModel ) {
//
//        username = user.data?.name
//        Verifyat = user.data?.isVerified
//        UserMail = user.data?.email
//        AllowEdite = user.data?.allow_edit
////        usercityid = user.city?.id
////        usercity = user.city?.name
//   }

func SetTokenDefaults(user: UserModel) {
    authToken = user.data?.token
    Verifyat = user.data?.isVerified
    username = user.data?.name
    userAddress = user.data?.address
    lattitude = user.data?.lat
    lantitude = user.data?.lng
  }
    
//    func SetTokenDefaults(user: SignUPModel) {
//        standerToken = user.data
//    }
    
    func SetFemToken(fem: String) {
        fcmToken = fem
    }

    func removeUserDefaults()  {
//         TappedViews = 0
      authToken = nil
      UserMail = nil
      username = nil

    }


    func Logout(){
        
//       let logout =  AppDelegate.app.pushNotifications
//        logout.clearAllState { }
        guard let window =  UIApplication.shared.keyWindow else { return }
        let storyboard = UIStoryboard(name: "AuthSb", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
        let VC = UINavigationController(rootViewController: rootViewController)
//        NetworkManager.shared.getData(logoutModel.self, Requst: .logout, method: .get, headerType: .authenticated) { (Massage, Data, Code) in
//            if Code == 204 {

                AuthService.instance.removeUserDefaults()
//                window.rootViewController = UserTapparVC()
//        navigationController?.pushViewController(rootViewController, animated: true)
//            }else{
//                AuthService.instance.removeUserDefaults()
                window.rootViewController = VC
//        }
//
//        }
        
    }
    



}
