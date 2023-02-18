//
//  CancelOrderCell.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import UIKit

class CancelOrderCell: UITableViewCell,Reuseable,CancelOrderCellView {

    @IBOutlet weak var mainView: UIView!
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

        // Configure the view for the selected state
    }
    
    func Data(number: String, status: String, total: String) {
       
        numberLabel.text = number
        statusLabel.text = status
    }
    
    
}
