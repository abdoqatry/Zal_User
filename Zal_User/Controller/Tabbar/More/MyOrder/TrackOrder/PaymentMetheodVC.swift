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

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
