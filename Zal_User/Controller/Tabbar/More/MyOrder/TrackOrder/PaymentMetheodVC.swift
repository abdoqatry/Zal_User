//
//  PaymentMetheodVC.swift
//  Zal_User
//
//  Created by Admin on 14/11/2023.
//

import UIKit
import OPPWAMobile

class PaymentMetheodVC: UIViewController,OPPCheckoutProviderDelegate, PKPaymentAuthorizationViewControllerDelegate{
    
    @IBOutlet weak var ApplePayBT: UIButton!
    @IBOutlet weak var StcPayBT: UIButton!
    @IBOutlet weak var VisaBT: UIButton!
    @IBOutlet weak var MadaBT: UIButton!
    @IBOutlet weak var AmountTF: UITextField!
    @IBOutlet weak var ConfirmBT: UIButton!
    @IBOutlet weak var CancelBT: UIButton!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var MainView: UIView!
    
    let provider = OPPPaymentProvider(mode: OPPProviderMode.live)
    var id = 0
    var PaymentType = ""
    var transaction : OPPTransaction?

    var checkout : OPPCheckoutProvider?
    var chickoutId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if chickoutId != "" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName5"), object: nil)
            dismiss(animated: true, completion: nil )
        }
    }
    
    func SetView(){
        ContentView.layer.cornerRadius = 16
        ConfirmBT.layer.cornerRadius = 12
        CancelBT.layer.cornerRadius = 12
        
    }
    
    @IBAction func StcPayButtom(_ sender: UIButton) {
        StcPayBT.setImage(UIImage(named: "Group 8691"), for: .normal)
        ApplePayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        VisaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        MadaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        PaymentType = "visa"
        id = 4
    }
    
    @IBAction func ApplePayButtom(_ sender: UIButton) {
        ApplePayBT.setImage(UIImage(named: "Group 8691"), for: .normal)
        VisaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        MadaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        StcPayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        PaymentType = "apple"
        id = 1
    }
    
    @IBAction func VisaButton(_ sender: UIButton) {
        VisaBT.setImage(UIImage(named: "Group 8691"), for: .normal)
        ApplePayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        MadaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        StcPayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        PaymentType = "visa"
        id = 2
        
    }
    
    @IBAction func MadaButton(_ sender: UIButton) {
        MadaBT.setImage(UIImage(named: "Group 8691"), for: .normal)
        VisaBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        ApplePayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        StcPayBT.setImage(UIImage(named: "Ellipse 570"), for: .normal)
        PaymentType = "mada"
        id = 3
        
    }
    
    @IBAction func ConfirmButton(_ sender: UIButton) {
        guard let amount = AmountTF.text , !amount.isEmpty else{
            showAlert(title: "please enter the transaction amount".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard id != 0  else {
            showAlert(title: "please choose payment type".localize, messages: nil, message: nil, selfDismissing: true)
       return }
        GetHyperId(amount: amount)
    }
    
    @IBAction func Cancelbutton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didReceiveAsynchronous() {
         NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey1"), object: nil)
         
//
        self.checkout?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                self.GetHyper(checkout_id: self.chickoutId)
            }
        }
          }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            
        controller.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }

        }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
            
//            print("checkoutgdfg \(checkoutID)")
            
            if let params = try? OPPApplePayPaymentParams(checkoutID: self.chickoutId, tokenData: payment.token.paymentData) as OPPApplePayPaymentParams? {
                params.shopperResultURL = "elzal.com://result"
                self.transaction  = OPPTransaction(paymentParams: params)
                
                self.provider.submitTransaction(OPPTransaction(paymentParams: params), completionHandler: { (transaction, error) in
                    if (error != nil) {
                        // See code attribute (OPPErrorCode) and NSLocalizedDescription to identify the reason of failure.
                        completion(.failure)
                        print(error?.localizedDescription)
                        print(error.debugDescription)
                    } else {
                        // Send request to your server to obtain transaction status.
                        completion(.success)
                        
//                        self.dismiss(animated:true){
                        self.GetHyper(checkout_id: self.chickoutId)
//                        }
                DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                // Put your code which should be executed with a delay here
                    self.dismiss(animated: true, completion: nil)
                    }
                            }
                        
                    }
                })
            }
        }

}
