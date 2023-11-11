//
//  NotificationCell.swift
//  Zal_User
//
//  Created by Admin on 11/11/2023.
//

import UIKit

class NotificationCell: UITableViewCell,Reuseable,notificationCellView {
    
    func Data(name: String, image: String) {
        let url = URL(string: image)
        notifiImg.kf.setImage(with: url)
        contantLabel.text = name
    }
    

    @IBOutlet weak var contantLabel: UILabel!
    @IBOutlet weak var notifiImg: UIImageView!
    @IBOutlet weak var notiview: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 20
        mainView.layer.applySketchShadow()
        notiview.layer.cornerRadius = 30
        notiview.clipsToBounds = true
        notifiImg.layer.cornerRadius = 30
        notifiImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
