//
//  MessagelistCell.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import UIKit

class MessagelistCell: UITableViewCell,Reuseable,MessageCellView {
    func Data(image: String, name: String, time: String, desc: String) {
        nameLabel.text = name
        timeLabel.text = time
        messageLabel.text = desc
        let url = URL(string: image)
        profileimg.kf.setImage(with: url)
    }

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = 30
        profileimg.layer.cornerRadius = 30
        profileView.clipsToBounds = true
        profileimg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
