//
//  MyOrderVC.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit

class MyOrderVC: UIViewController {

    @IBOutlet weak var refuseLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var finishedLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var HeaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Orders".localize
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddNewView()
    }
    
    func setView(){
    
        HeaderView.layer.cornerRadius = 18
        refuseLabel.layer.cornerRadius = 8
        currentLabel.layer.cornerRadius = 8
        finishedLabel.layer.cornerRadius = 8
       
        currentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddNewView)))
        finishedLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddFinishView)))
        refuseLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddRefuseView)))
    }
    
    @objc func AddNewView(){
   
        currentLabel.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 0.3259002484)
        finishedLabel.backgroundColor = .clear
        refuseLabel.backgroundColor = .clear
        currentLabel.textColor = #colorLiteral(red: 0.6213923097, green: 0.1011295542, blue: 0.3701999784, alpha: 1)
        finishedLabel.textColor = .darkGray
        refuseLabel.textColor = .darkGray
     mainView.subviews.forEach({ $0.removeFromSuperview() })
       
         let VC = Bundle.main.loadNibNamed("CurrentOrderVC", owner: nil, options: nil)![0] as! CurrentOrderVC
         let controller = VC
         addChild(controller)
            mainView.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            mainView.addSubview(controller.view)

         controller.didMove(toParent: self)
         controller.view.frame = CGRect(x:0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
      
   
     }
    
    @objc func AddFinishView(){
        currentLabel.backgroundColor = .clear
        finishedLabel.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 0.3259002484)
        refuseLabel.backgroundColor = .clear
        currentLabel.textColor = .darkGray
        finishedLabel.textColor = #colorLiteral(red: 0.6213923097, green: 0.1011295542, blue: 0.3701999784, alpha: 1)
        refuseLabel.textColor = .darkGray
     mainView.subviews.forEach({ $0.removeFromSuperview() })
       
         let VC = Bundle.main.loadNibNamed("FinishedOrderVC", owner: nil, options: nil)![0] as! FinishedOrderVC
         let controller = VC
         addChild(controller)
            mainView.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            mainView.addSubview(controller.view)

         controller.didMove(toParent: self)
         controller.view.frame = CGRect(x:0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
      
   
     }
    
    @objc func AddRefuseView(){
        currentLabel.backgroundColor = .clear
        finishedLabel.backgroundColor = .clear
        refuseLabel.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 0.3259002484)
        currentLabel.textColor = .darkGray
        finishedLabel.textColor = .darkGray
        refuseLabel.textColor = #colorLiteral(red: 0.6213923097, green: 0.1011295542, blue: 0.3701999784, alpha: 1)
     mainView.subviews.forEach({ $0.removeFromSuperview() })
       
         let VC = Bundle.main.loadNibNamed("CancelOrderVC", owner: nil, options: nil)![0] as! CancelOrderVC
         let controller = VC
         addChild(controller)
            mainView.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            mainView.addSubview(controller.view)
       
         controller.didMove(toParent: self)
         controller.view.frame = CGRect(x:0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
      
   
     }

}
