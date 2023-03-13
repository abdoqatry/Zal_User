//
//  CurrentOrderCell.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit

class CurrentOrderCell: UITableViewCell,Reuseable,CurrentOrderCellView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var trackOrderBT: UIButton!
    @IBOutlet weak var stratChatBT: UIButton!
    
    var trackOrderafunction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
     setView()
    }
    
    func setView(){
        trackOrderBT.layer.cornerRadius = 16
        stratChatBT.layer.cornerRadius = 16
        stratChatBT.layer.borderWidth = 0.5
        stratChatBT.layer.borderColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        mainView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func Data(number: String, status: String, total: String) {
        priceLabel.text = total
        numberLabel.text = number
        statusLabel.text = status
    }
    
    
    @IBAction func startChatAction(_ sender: UIButton) {
        
    }
    
    @IBAction func trackOrderAction(_ sender: UIButton) {
        trackOrderafunction!()
    }
    
}
