//
//  MoreCell.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import UIKit

class MoreCell: UITableViewCell,Reuseable {

    @IBOutlet weak var iconeIamge: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: dummyItem){
        nameLabel.text = viewModel.name
        iconeIamge.image = UIImage(named: viewModel.image)
    }
    
}
