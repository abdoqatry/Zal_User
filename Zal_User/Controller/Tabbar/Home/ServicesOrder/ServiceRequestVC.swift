//
//  ServiceRequestVC.swift
//  Zal_User
//
//  Created by Admin on 02/10/2023.
//

import UIKit

class ServiceRequestVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var sendBT: UIButton!
    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var MessageTV: UITextView!
    
    var date1 = ""
    var time = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        title = "Service Request".localize
        sendBT.layer.cornerRadius = 14
        timeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenTimefrom)))
        dayLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Opendays)))
        MessageTV.delegate = self
        MessageTV.text = "Description of the required service".localize
        for i in itemsView{
            i.layer.cornerRadius = 22
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
     
        if textView.text == "Description of the required service" || textView.text == "وصف الخدمة المطلوبة" {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)

        }
        
    }


    func textViewDidEndEditing(_ textView: UITextView) {

            if textView.text.isEmpty {
                textView.text = "Description of the required service".localize
                textView.textColor = UIColor.gray
        }
       
    }
    
    @IBAction func sendButton(_ sender: Any) {
      
        if MessageTV.text == "وصف الخدمة المطلوبة" || MessageTV.text == "Description of the required service" {
            showAlert(title:  "Enter message contant".localize, messages: nil, message: nil, selfDismissing: true)
            return
        }
        guard time != "" || date1 != "" else{
            showAlert(title:  "please Choose time".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        sendServices(desc: MessageTV.text ?? "", day: date1, time: time)
    }
    @objc func Opendays(){

        let myView = Bundle.main.loadNibNamed("DateController", owner: nil, options: nil)![0] as! DateController
                 myView.delegetDate = self
        myView.mode = 1
        myView.type = 1
        presentPop(viewController: myView)
        }
    @objc func OpenTimefrom(){

        let myView = Bundle.main.loadNibNamed("DateController", owner: nil, options: nil)![0] as! DateController
                 myView.delegetDate = self
        myView.mode = 2
        myView.type = 1
        presentPop(viewController: myView)
        }
    
    func sendServices(desc:String,day:String,time:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ServicesOrderModel.self, Requst: .service_orders(desc: desc, day: day, time: time), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }


}


extension ServiceRequestVC : GetDateProtocole{

    func dateView(didSelect date: String, mode: Int,type:Int) {
    if date == "" {
       taxDateLabel.text = ""
        taxDateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        date2 = date
//        TimeLabel = date
        
    }else{
        if mode == 1 {
            dayLabel.text = date
            dayLabel.textColor = .black
            date1 = date
        }else if mode == 2 {
            timeLabel.text = date
            timeLabel.textColor = .black
            time = date
        }
        
    }
}
    
}
