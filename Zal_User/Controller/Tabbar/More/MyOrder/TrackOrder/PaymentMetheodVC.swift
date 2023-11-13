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
    
    func GetHyperId(amount:String){
       
     openIndicator(title: Constants.PLEASE_WAIT, description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(GetHyperPayModel.self, Requst: .get_checkout_id(amount: amount, paymentType: PaymentType),method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
        self?.closeIndicator()
         if Code == 200{
             self?.chickoutId = Data?.data?.checkoutID ?? ""
             self?.openHyperPay(chickid: Data?.data?.checkoutID ?? "" )
            
         }else if Code == 422{
            let msg = Data?.message ?? ""
             self?.showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
         } else {
            let msg = Constants.UNEXPECTED_ERROR
             self?.showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
         }
     
     }
     
         
     }
    
    
    func openHyperPay(chickid:String){
        if id == 1 {
            let request = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.com.elZal.Zal", countryCode: "SA")
            request.supportedNetworks = [
                .masterCard,
                .visa,
                .mada

            ]
                    // Set currency.
                    request.currencyCode = "SAR"
            request.supportedCountries = ["SA"]
            
                    // Create total item. Label should represent your company.
                    // It will be prepended with the word "Pay" (i.e. "Pay
            
            guard let balance = AmountTF.text , !balance.isEmpty else{

            return  }
            
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Zal app", amount: NSDecimalNumber(string: balance))]
            
            //  let request1 = PKPaymentRequest() // See above
            if OPPPaymentProvider.canSubmitPaymentRequest(request) {
            if let vc = PKPaymentAuthorizationViewController(paymentRequest: request) as PKPaymentAuthorizationViewController? {
                    vc.delegate = self
                present(vc, animated: true, completion: nil)
                        } else {
                            NSLog("Apple Pay not supported.");
                        }
                    }
            
            
        }else{
            
            //        AuthService.instance.typeWallet = 1
            let checkoutSettings = OPPCheckoutSettings()
            
            
            
            let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.com.elZal.Zal", countryCode: "SA")
            paymentRequest.supportedNetworks = [
                .masterCard,
                .visa,
                .mada,
            ]
            
            paymentRequest.supportedCountries = ["SA"]
            //        paymentRequest.merchantCapabilities : ["supports3DS"]
            
            guard let balance = AmountTF.text , !balance.isEmpty else{
                
                return  }
            
            let total = PKPaymentSummaryItem(label: "Zal App", amount: NSDecimalNumber(string: balance))
            
            //        summaryItems = [total]
            paymentRequest.paymentSummaryItems = [total]
            
            //        paymentRequest.currencyCode = "USD"
            checkoutSettings.language = "ar"
            checkoutSettings.theme.navigationBarTintColor = UIColor.black
            checkoutSettings.theme.confirmationButtonColor = #colorLiteral(red: 0.6666666667, green: 0.003921568627, blue: 0.0862745098, alpha: 1)
            checkoutSettings.theme.navigationBarBackgroundColor = #colorLiteral(red: 0.6666666667, green: 0.003921568627, blue: 0.0862745098, alpha: 1)
            // Set shopper result URL
            checkoutSettings.shopperResultURL = "elzal.com://result"
            
            
            checkoutSettings.applePayPaymentRequest = paymentRequest
            checkoutSettings.storePaymentDetails = .never
            
            if id == 1 {
                checkoutSettings.paymentBrands = ["APPLEPAY"]
                checkoutSettings.theme.paymentBrandIconBorderColor = .black
            }else if id == 2 {
                checkoutSettings.paymentBrands = ["VISA","MASTER"]
            }else if id == 3 {
                checkoutSettings.paymentBrands = ["MADA"]
            }else if id == 4 {
                checkoutSettings.paymentBrands = ["STC_PAY"]
            }
            
            
            self.checkout = OPPCheckoutProvider(paymentProvider: provider, checkoutID: chickid, settings: checkoutSettings)
            
            checkout?.delegate = self
            checkout?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                guard let transaction = transaction else {
                    // Handle invalid transaction, check error
                    self.showAlert(title: error?.localizedDescription ?? "", messages: nil, message: nil, selfDismissing: false)
                    print(error?.localizedDescription)
                    return
                }
                
                
                print("transaction = \(transaction)")
                if transaction.type == .synchronous {
                    // If a transaction is synchronous, just request the payment status
                    // You can use transaction.resourcePath or just checkout ID to do it
                    self.GetHyper(checkout_id: chickid)
                    
                } else if transaction.type == .asynchronous {
                    // The SDK opens transaction.redirectUrl in a browser
                    // See 'Asynchronous Payments' guide for more details
                    NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronous), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey1"), object: nil)
                    
                    //               self.GetHyper(checkout_id: chickid)
                    
                    
                } else {
                    // Executed in case of failure of the transaction for any reason
                    //
                    
                }
            }
                                      , cancelHandler: {
                // Executed if the shopper closes the payment page prematurely
                print("Error6")
                //            self.GetHyper(chickid: chickid)
                
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        
        }
    
    func GetHyper(checkout_id:String){
        openIndicator(title: Constants.PLEASE_WAIT, description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(PaymentChickModel.self, Requst: .check_status(paymentType: PaymentType, id: checkout_id), method: .get, headerType: .authenticated) { [weak self](Message, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.showAlert(title: Data?.message ?? "", messages:nil, message: nil, selfDismissing: true)
                DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                // Put your code which should be executed with a delay here
               
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName5"), object: nil)
                self?.GetCharge(checkout_id: checkout_id)
                self?.dismiss(animated: true, completion: nil )
    }
                }
            }else if Code == 422 {
                self?.showAlert(title: Data?.message ?? "" , messages:nil, message: nil, selfDismissing: true)
            }else{
                self?.showAlert(title: Constants.UNEXPECTED_ERROR , messages:nil, message: nil, selfDismissing: true)
            }
            
        }
    }

}
