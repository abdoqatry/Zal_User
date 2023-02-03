//
//  CityPosition.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

protocol CItyprotocole {
    func passCity(value : String,Id :Int,code:String)
}

class CityPositionVC: UIViewController {

   
    
    var mainview : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7172784675)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var contantview : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var pickerview : UIPickerView = {
        let picker = UIPickerView()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    var OkButt : UIButton = {
        let butt = UIButton()
        butt.setTitle("Confirm".localize, for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.isHidden = true
        butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    var cancelButt : UIButton = {
        let butt = UIButton()
        butt.setTitle("Cancel".localize, for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    
    var delegetCity : CItyprotocole?
    var Id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        pickerview.delegate = self
        pickerview.dataSource = self
        setview()
        settarget()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let CityId = String(id)
        getPosition(id: Id)
    }
    
    
    
    var availapositions = [Citi] ()
    {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.pickerview.reloadAllComponents()
            }
        }
    }
    
    func getPosition(id:String){
        openIndicator(title: Constants.PLEASE_WAIT, description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CityModel.self, Requst: .citieslist, method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200{
                if Data?.data?.count != 0 {
//                if Data?.status == true{
//                    if Data?.cities?.count != 0 {
                        var date = Data?.data ?? []
                        let person1: Citi = Citi(id: 0, name: "Select City".localize, code: "-10", image: "")
                    date.insert(person1, at: 0)
                        self?.availapositions = date
                    }
//                }else{
//                self?.showAlert(title: Constants.UNEXPECTED_ERROR, messages: nil, message: nil, selfDismissing: false)
//                }
            }else{
                self?.showAlert(title: Constants.UNEXPECTED_ERROR, messages: nil, message: nil, selfDismissing: false)
            }
        }
    }
    
    
    func setview(){
        view.addSubview(mainview)
        NSLayoutConstraint.activate([
            mainview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        mainview.addSubview(contantview)
        NSLayoutConstraint.activate([
            contantview.bottomAnchor.constraint(equalTo: mainview.bottomAnchor, constant: 0),
            contantview.leadingAnchor.constraint(equalTo: mainview.leadingAnchor, constant: 0),
            contantview.trailingAnchor.constraint(equalTo: mainview.trailingAnchor, constant: 0),
            contantview.heightAnchor.constraint(equalToConstant: 250)
            ])
        contantview.addSubview(OkButt)
        NSLayoutConstraint.activate([
            OkButt.topAnchor.constraint(equalTo: contantview.topAnchor, constant: 10),
            OkButt.trailingAnchor.constraint(equalTo: contantview.trailingAnchor, constant: -10),
            OkButt.heightAnchor.constraint(equalToConstant: 16)
            ])
        contantview.addSubview(cancelButt)
        NSLayoutConstraint.activate([
            cancelButt.topAnchor.constraint(equalTo: contantview.topAnchor, constant: 10),
            cancelButt.leadingAnchor.constraint(equalTo: contantview.leadingAnchor, constant: 10),
            cancelButt.heightAnchor.constraint(equalToConstant: 16)
            ])
        contantview.addSubview(pickerview)
        NSLayoutConstraint.activate([
            pickerview.topAnchor.constraint(equalTo: contantview.topAnchor, constant: 30),
            pickerview.leadingAnchor.constraint(equalTo: contantview.leadingAnchor, constant: 50),
            pickerview.centerXAnchor.constraint(equalTo: contantview.centerXAnchor, constant: 0),
            pickerview.bottomAnchor.constraint(equalTo: contantview.bottomAnchor, constant: 0)
            ])
        
    }
    var Name = ""
    var id = 0
    var code = ""
    @objc func Confirm(){
      
        print(Name)
        delegetCity?.passCity(value : Name,Id :id,code:code)
        dismiss(animated: true, completion: nil)
    }
    @objc func diss(){
        delegetCity?.passCity(value : "",Id :-1,code:"-1")
        dismiss(animated: true, completion: nil)
    }
    func settarget(){
        OkButt.addTarget(self, action: #selector(Confirm), for: .touchUpInside)
        cancelButt.addTarget(self, action: #selector(diss), for: .touchUpInside)
    }
    
    
}

extension CityPositionVC : UIPickerViewDelegate,UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return availapositions.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //        self.view.endEditing(true)
        Name = availapositions[row].name ?? ""
        id = availapositions[row].id ?? 0
        code = availapositions[row].code ?? ""
        return availapositions[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
//        SVProgressHUD.dismiss()
        if availapositions[row].code != "-10" {
        if availapositions.count != 0{
            Name = availapositions[row].name ?? ""
                   id = availapositions[row].id ?? 0
                   code = availapositions[row].code ?? ""
            delegetCity?.passCity(value : Name,Id :id,code:code)
                   dismiss(animated: true, completion: nil)
//            delegetCity?.passCity(value: Name, Id: id)
//           dismiss(animated: true, completion: nil)
        }else {
            showAlert(title: "check your network".localize, messages: nil, message: nil, selfDismissing: true)
            }
        }
       
        
    }
}



