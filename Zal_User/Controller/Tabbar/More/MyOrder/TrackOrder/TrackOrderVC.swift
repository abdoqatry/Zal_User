//
//  TrackOrderVC.swift
//  Zal_User
//
//  Created by Admin on 18/02/2023.
//

import UIKit

class TrackOrderVC: UIViewController,TrackOrderProtocol {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func getData(status: String) {
        if status == "pending" {
            orderReviewView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestNotificationLAbel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestReviewLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsReviewView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            orderAcceptedView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            requestAcceptedLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            orderAceptedLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            uderDeliverView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            orderUnderDeliverLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            requestUnderDeliverLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsUndeDeliverView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            deliverdView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            deliveredLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            cancelBT.isHidden = false
        }else if status == "accept" {
            orderReviewView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestNotificationLAbel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestReviewLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsReviewView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            orderAcceptedView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestAcceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            orderAceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            uderDeliverView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            orderUnderDeliverLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            requestUnderDeliverLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsUndeDeliverView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            deliverdView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            deliveredLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            cancelBT.isHidden = true
        }else if status == "on_the_way" {
            orderReviewView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestNotificationLAbel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestReviewLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsReviewView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            orderAcceptedView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestAcceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            orderAceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            uderDeliverView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            orderUnderDeliverLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestUnderDeliverLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsUndeDeliverView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            deliverdView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            deliveredLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
            cancelBT.isHidden = true
        }else if status == "complete" {
            orderReviewView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestNotificationLAbel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestReviewLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsReviewView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            orderAcceptedView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestAcceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            orderAceptedLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            uderDeliverView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            orderUnderDeliverLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            requestUnderDeliverLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsUndeDeliverView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            deliverdView.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            deliveredLabel.textColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            for i in itemsAcceptedView{
                i.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
            }
            cancelBT.isHidden = true
        }
        
    }
    

    @IBOutlet weak var requestNotificationLAbel: UILabel!
    @IBOutlet weak var requestReviewLabel: UILabel!
    @IBOutlet var itemsReviewView: [UIView]!
    @IBOutlet weak var orderReviewView: UIView!
    @IBOutlet weak var orderNumTF: UILabel!
    @IBOutlet weak var orderAcceptedView: UIView!
    @IBOutlet weak var requestAcceptedLabel: UILabel!
    @IBOutlet var itemsAcceptedView: [UIView]!
    @IBOutlet weak var orderAceptedLabel: UILabel!
    @IBOutlet weak var orderUnderDeliverLabel: UILabel!
    @IBOutlet weak var requestUnderDeliverLabel: UILabel!
    @IBOutlet weak var deliverdView: UIView!
    @IBOutlet weak var deliveredLabel: UILabel!
    @IBOutlet var itemsUndeDeliverView: [UIView]!
    @IBOutlet weak var uderDeliverView: UIView!
    @IBOutlet weak var cancelBT: UIButton!
    
    var id = ""
    
    var presenter : TrackPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TrackPresenter(self)
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getOrderDetails(id: id)
    }
    
    func setView(){
        orderReviewView.layer.cornerRadius = 30
        orderAcceptedView.layer.cornerRadius = 30
        deliverdView.layer.cornerRadius = 30
        uderDeliverView.layer.cornerRadius = 30
        cancelBT.layer.cornerRadius = 12
        
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
    }
    

}
