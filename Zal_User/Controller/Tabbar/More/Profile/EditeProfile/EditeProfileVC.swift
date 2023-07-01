//
//  EditeProfileVC.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditeProfileVC: UIViewController {

    @IBOutlet weak var SaveBt: UIButton!
    @IBOutlet weak var pgoneTF: UITextField!
    @IBOutlet weak var MailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editPenImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        setView()
        getProfile()
    }
    
    var ProfileImage : UIImage?
    
    func setView(){
        title = "Profile".localize
        SaveBt.layer.cornerRadius = 18
        profileView.layer.cornerRadius = 60
        profileImage.layer.cornerRadius = 60
        profileView.layer.applySketchShadow()
        for i in itemsView{
            i.layer.cornerRadius = 25
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        editPenImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
    }
    
    
    @IBAction func EditeButton(_ sender: UIButton) {
        uploadProfile()
    }
    
    func getProfile(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProfileModel.self, Requst: .profile, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                let profileUrl = URL(string: Data?.data?.image ?? "")
                self?.nameTF.text = Data?.data?.name ?? ""
                self?.MailTF.text = Data?.data?.email ?? ""
                self?.pgoneTF.text = Data?.data?.phone ?? ""
                self?.profileImage.kf.setImage(with: profileUrl)
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    func uploadProfile(){
        let img : UIImage?
      
      if ProfileImage != nil{
          img = ProfileImage ?? UIImage()
      }else {
          img = profileImage.image ?? UIImage()
//      showAlert(title:  "من فضلك اختر الصورة الشخصية", messages: nil, message: nil, selfDismissing: true)
//          return
      }
        
        guard let name = nameTF.text , !name.isEmpty  else{
            showAlert(title:  "Enter user name".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
        guard let phone = pgoneTF.text , !phone.isEmpty  else{
            showAlert(title:  "Enter Phone Number".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
        guard  let mail = MailTF.text , !mail.isEmpty , mail.isEmail  else{
            showAlert(title:  "Enter valid mail".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
        openIndicator(title: Constants.PLEASE_WAIT, description: Constants.LOADING_DATA)
            let url = "https://zal.develobug.com/api/profile"
            let parameter = [
                "name" : name,
                "phone" : phone,
                "email" : mail
           
                ] as [String : Any]
AF.upload(
          multipartFormData: { multipartFormData in
            for (key, value) in parameter {
              multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
          }
//                    let data2 = NSData()
//                    if self.imageArray.count == 0{
//
//                    }else{
//                 for (index, image) in self.imageArray.enumerated() {

    multipartFormData.append(img!.jpegData(compressionQuality: 0.2)!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
 
//            multipartFormData.append(img4!.jpegData(compressionQuality: 0.2)!, withName: "commercial_image", fileName: "commercial_image.jpeg", mimeType: "image/jpeg")
//                    }
//                    }
            
        },
          to: url, method: .post , headers: Headers.authenticatedHeader )
                      .response { response in
            self.closeIndicator()
            let temp = response.response?.statusCode ?? 400
            
            if let _ = response.error{

                return
            }
            
            print("Succesfully uploaded----\(response)")
            let json = JSON(response.value ?? [:])
                                    print(json)
    do {
            //
        
let data = try newJSONDecoder().decode(ProfileModel.self, from: response.data!)
                if temp == 200{
   
//         let token = data
//    AuthService.instance.authToken = data.data ?? ""
//    AuthService.instance.Verifyat = false
//    AuthService.instance.hasBank = false
//            AuthService.instance.SetTokenDefaults(user: token)

        self.navigationController?.popViewController(animated: true)
   
            print("Succed shop")
        }else if temp == 422{
        
        self.showAlert(title: data.message ?? "", messages: nil, message: nil, selfDismissing: false)
//                                        AuthService.instance.logout()
                 }
            //
        }
            catch let error {
//                                            completion?(nil, nil, temp)
        self.showAlert(title: Constants.UNEXPECTED_ERROR, messages: nil, message: nil, selfDismissing: false)
                print(error)
            }
                        
            

    
}
        
    }
    
    // chose image
     @objc func chooseImage(){
         let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
             if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                 
                 self.imagePicker.delegate = self
                 self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                 self.imagePicker.allowsEditing = false
                 self.present((self.imagePicker)!, animated: true, completion: nil)
             }
         }))
         
         alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
             if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                 self.imagePicker.delegate = self
                 self.imagePicker.sourceType = .savedPhotosAlbum;
                 self.imagePicker.allowsEditing = false
                 self.present((self.imagePicker)!, animated: true, completion: nil)
             }
         }))
         
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
             alert.dismiss(animated: true, completion: nil)
         }))
         
         present(alert, animated: true)
         
     }
    

}


extension EditeProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           
                ProfileImage = pickedImage
                profileImage.image = pickedImage
            
//            cameraView.contentMode = .scaleAspectFill
            

        }
        picker.dismiss(animated: true, completion: nil)
    }
}
