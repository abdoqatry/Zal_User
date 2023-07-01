//
//  CheckOutVC.swift
//  Zal_User
//
//  Created by Admin on 22/03/2023.
//

import UIKit

class CheckOutVC: UIViewController,CeckoutProtocol {
    func errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func dataReload() {
        
    }
    
    func navigatetoorder(id:String,num:String) {
        AuthService.instance.id = id
        AuthService.instance.orderNum = num 
        let vc = Bundle.main.loadNibNamed("MyOrderVC", owner: nil, options: nil)![0] as! MyOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.global(qos: .background).async {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "OpenOrders"), object: nil)
        }
            }

    }
    

    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var deliverChargeLabel: UILabel!
    @IBOutlet weak var completeOrderBT: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var addressId = 0
    var date = ""
    var paymentcode = "cash"
    
    var presenter : CechoutPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CechoutPresenter(self)
        setView()
    }
    
    func setView(){
        title = "Checkout".localize
        addressView.layer.cornerRadius = 16
        addressView.layer.borderColor = UIColor.darkGray.cgColor
        addressView.layer.borderWidth = 0.5
        dateView.layer.cornerRadius = 16
        dateView.layer.borderColor = UIColor.darkGray.cgColor
        dateView.layer.borderWidth = 0.5
        
        paymentView.layer.cornerRadius = 16
        paymentView.layer.borderColor = UIColor.darkGray.cgColor
        paymentView.layer.borderWidth = 0.5
        
        completeOrderBT.layer.cornerRadius = 16
        addressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.getAddress)))
        dateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openTime)))
        paymentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPatment)))
    }
    
    @objc func getAddress(){
         let vc = AddressPositionVC()
        self.view.endEditing(true)
        
        vc.delegetAddress = self
         presentPop(viewController: vc)
     }
    
    @IBAction func completOrderButton(_ sender: Any) {
        
        if addressId == 0 {
            showAlert(title:  "choose address".localize, messages: nil, message: nil, selfDismissing: true)
            return
        }
        
        if date == "" {
            showAlert(title:  "choose date".localize, messages: nil, message: nil, selfDismissing: true)
            return
        }
        
        presenter?.addCart(addressId: String(addressId), pay:paymentcode, date: date)
    }
    
    @objc func openTime(){
            
        let myView = Bundle.main.loadNibNamed("DateController", owner: nil, options: nil)![0] as! DateController
                 myView.delegetDate = self
       
        myView.mode = 0
        presentPop(viewController: myView)
        }
    
    @objc func openPatment(){
         let modalViewController = PaymentPositionVC()
        self.view.endEditing(true)
        
        modalViewController.delegetAddress = self
         presentPop(viewController: modalViewController)
     }
    

}


extension CheckOutVC:Addressprotocole{
    
    func passAddress(value: String, Id: Int, lat: String, lon: String, code: String) {
        if value != "" {
            addressLabel.text = value
            addressId = Id
           
        }
    }
}


extension CheckOutVC : GetDateProtocole{
    
    func dateView(didSelect date: String, mode: Int,type:Int) {
        if date == "" {
            dateLabel.text = "choose date".localize
            self.date = date
            
        }else{
            print(date)
            dateLabel.text = date
            self.date = date
        }
        
    }
    
}

extension CheckOutVC : Paymentprotocole{
    func passPayment(value: String, Id: String, code: String) {
        if Id != "" {
            self.paymentcode = Id
            self.paymentLabel.text = value
        }else{
            self.paymentcode = "cash"
            self.paymentLabel.text = "Cash".localize
        }
    }
    
}
