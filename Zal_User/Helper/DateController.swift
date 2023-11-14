//
//  DateController.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

protocol GetDateProtocole {
    func dateView(didSelect date: String, mode : Int,type:Int)
}

class DateController: UIViewController {

    @IBOutlet weak var TitleStatus: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var mode = 0
    var type = 0
    var minMonth = 0
    
    var minDate: String! {
        willSet {
            datePicker.minimumDate = self.configDate(date: newValue)
        }
    }
    // set max date if you need to limit user in maximum date
    var maxDate: String! {
        willSet {
            datePicker.maximumDate = self.configDate(date: newValue)
        }
    }
    
    //set the delegate refrence to know the call back
    var delegetDate : GetDateProtocole?
    override func viewDidLoad() {
        super.viewDidLoad()

    self.mainView.isUserInteractionEnabled = true
    self.mainView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(dismissViews)))
               
//        datePicker.calendar = Calendar(identifier: .d)
     
       
        datePicker.preferredDatePickerStyle = .wheels
    for currentView in datePicker.subviews {
        currentView.semanticContentAttribute = .forceRightToLeft
        }
        
//        let calendar = Calendar(identifier: .gregorian)
//
        let currentDate = Date()
//        var components = DateComponents()
//        components.calendar = calendar
//
//
////        components.year = +18
////        components.month = 12
//        let maxDate = calendar.date(byAdding: components, to: currentDate)!
//
////        components.year =
//        let minDate = calendar.date(byAdding: components, to: currentDate)!
//
//        datePicker.minimumDate = minDate
        
//        datePicker.maximumDate = maxDate
        datePicker.date = currentDate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if mode == 1 {
        datePicker.datePickerMode = .date
        TitleStatus.text = "Choose date".localize
        datePicker.preferredDatePickerStyle = .wheels
    for currentView in datePicker.subviews {
        currentView.semanticContentAttribute = .forceRightToLeft
        }
        
        let calendar = Calendar(identifier: .gregorian)

        let currentDate = Date()
        var components = DateComponents()
        components.month = minMonth
        components.calendar = calendar
       

//        components.year = +18
//        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: currentDate)!

//        components.year =
        let minDate = calendar.date(byAdding: components, to: currentDate)!

//            if type == 2 {
//                datePicker.minimumDate = minDate
//            }else{
//                datePicker.maximumDate = maxDate
//            }
        }else if mode == 2 {
            datePicker.datePickerMode = .dateAndTime
        }else{
            datePicker.datePickerMode = .time
            TitleStatus.text = "Choose time".localize
        }
        
    }

    
    //MARK: - IBAction func
    @IBAction func Confirm(_ sender: UIButton) {
        //get date from date picker
        if mode == 1 {
        let dataAsString = self.configDate(date: datePicker.date)
        delegetDate?.dateView(didSelect: dataAsString, mode: mode, type: type)
            self.dismissViews()
        }else if mode == 2 {
            let dataAsString = self.configDate2(date: datePicker.date)
            delegetDate?.dateView(didSelect: dataAsString, mode: mode, type: type)
                self.dismissViews()
        }else{
            let dataAsString = self.configtime(date: datePicker.date)
            delegetDate?.dateView(didSelect: dataAsString, mode: mode, type: type)
                self.dismissViews()
        }
        
    }
    
    @IBAction func Cancel(_ sender: UIButton) {
//         delegetDate?.dateView(didSelect: "")
        self.dismissViews()
    }
    
    @objc func dismissViews() {
        dismiss(animated: false, completion: nil)
    }
    
    //convert date from date to string
    func configDate(date: Date) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter.string(from: date)
    }
    //convert date from string to date
    func configDate(date: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter.date(from: date)!
    }
    
    
    func configDate2(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter.string(from: date)
    }
    
    func configtime(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        return dateFormatter.string(from: date)
    }
  

}



