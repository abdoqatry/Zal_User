//
//  FinishedOrderCell.swift
//  Zal_User
//
//  Created by Admin on 14/02/2023.
//

import UIKit

class FinishedOrderCell: UITableViewCell,Reuseable ,FinishOrderCellView{
    func Data(number: String, status: String, total: String) {
        priceLabel.text = total
        numberLabel.text = number
        statusLabel.text = status
    }
    

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
       }
       
       func setView(){
           mainView.layer.cornerRadius = 8
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
