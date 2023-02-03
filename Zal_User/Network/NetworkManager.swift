//
//  NetworkManager.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//


import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getData<T: Codable>(_ decoder: T.Type, Requst:Router, method: HTTPMethod = .post,headerType: HeaderType, complation: @escaping (_ error: String?, _ data: T?,_ code:Int) -> Void) {
        
       
           
            let headers: HTTPHeaders!
            
            switch headerType{
            case .authenticated:
                headers = Headers.authenticatedHeader
            case .unAuthenticated:
                headers = Headers.unAuthenticatedHeader
            }
            
            let manager = AF
//            manager.session.configuration.timeoutIntervalForRequest = 25
            manager.session.configuration.httpShouldUsePipelining = true
        
            
            manager.request(Requst.requestURL, method: method, parameters:Requst.parameter,encoding: JSONEncoding.default,headers: headers)
                .responseJSON {
                    (response) in
        let statusCode = response.response?.statusCode ?? 0
                    if statusCode < 200 {
                        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internetconection"), object: nil)
                        
                return
                    }else if statusCode == 401 {
                        if AuthService.instance.authToken == "" || AuthService.instance.authToken == nil {
                            
                        }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Logout"), object: nil)
//                        return
                        }
                    }
                    
                    switch response.result {
                    case .failure(let error):
                        if error.localizedDescription.contains("JSON") {
                            complation("Servar Error.", nil, statusCode)
                            print(error.localizedDescription)
                        }else{
                            complation(error.localizedDescription, nil, statusCode)
                            print(error.localizedDescription)
                        }
                        
                    case .success(_):
                        if let responseData = response.data{
                let json = JSON(response.value ?? [:])
                            print(json)
                            do {
//
        let data = try newJSONDecoder().decode(T.self, from: responseData)
                    complation("success", data, statusCode)
//
                            }
            catch let error {
                complation(error.localizedDescription, nil, statusCode)
                    print(error)
                            }
                        }
                        else {
                            complation("Error", nil, statusCode)
                        }
                    }
            }

    }
    

    
    
    
    func uploadToServerWith<T: Codable>(_ decoder: T.Type, data: UploadData, url: String, method: HTTPMethod = .post,headerType: HeaderType, parameters: [String:Any]?, progress: ((Progress) -> Void)?, completion: ((_ error: String?, _ data: T?,_ code :Int) -> Void)? = nil) {
        
        let headers: HTTPHeaders!
                  
                  switch headerType{
                  case .authenticated:
                      headers = Headers.authenticatedHeader
                  case .unAuthenticated:
                      headers = Headers.unAuthenticatedHeader
                  }
        let progressView = UIProgressView()
        progressView.progressTintColor = .green
        progressView.progressViewStyle = .bar
//        let download = 20
//        SVProgressHUD.show()
        
        AF.upload(
                  multipartFormData: { multipartFormData in
                    for (key, value) in parameters ?? [:]{
                      multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                  }
//                    let data2 = NSData()
                    if data.data == nil{
                        
                    }else{
                        multipartFormData.append(data.data!, withName: data.name, fileName: data.fileName, mimeType: data.mimeType)
                       
                    }
                    
                },
          
            
                to: url, method: .post , headers:  headers)
//            .uploadProgress { progress in
//                 print("Upload Progress: \(progress.fractionCompleted)")
//                progressView.setProgress(Float(progress.fractionCompleted) / Float(
//                                            1.0 ), animated: true)
//             }
             .downloadProgress { progress in
                 print("Download Progress: \(progress.fractionCompleted)")
             }
            
//
//                }
         
            .uploadProgress(queue: .main, closure: { progress in
                        //Current upload progress of file
                print(progress)
                        print("Upload Progress: \(progress.fractionCompleted)")
//                progressView.setProgress(Float(progress.fractionCompleted) / Float(
//                                            1.0 ), animated: true)
                    })
                        
            .response { response in
                        let temp = response.response?.statusCode ?? 400
                        
                        if let _ = response.error{
//                              HUD.hide()
                            completion?(nil, nil, temp)
                            return
                        }
              
//                        SVProgressHUD.dismiss()
                    
                        print("Succesfully uploaded----\(response)")
                let json = JSON(response.value ?? [:])
                                    print(json)
                do {
            //
                    let data = try newJSONDecoder().decode(T.self, from: response.data!)
                            completion?(nil, data, temp)
                    //
                                                }
                                catch let error {
                                    completion?(nil, nil, temp)
                                        print(error)
                                                }
                                
                    
 
            
        }
        
    }
    

    
}


struct UploadData {
    var data: Data?
    var fileName, mimeType, name: String
}



