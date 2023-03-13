//
//  AdressCell.swift
//  Zal_User
//
//  Created by Admin on 11/03/2023.
//

import UIKit

class AdressCell: UITableViewCell,Reuseable ,AddressListCellView{

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var deletefunction: (() -> Void)?
    var editfunction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Data(title: String, description: String, id: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        deletefunction!()
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        editfunction!()
    }
    
}
