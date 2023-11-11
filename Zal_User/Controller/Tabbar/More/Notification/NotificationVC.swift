//
//  NotificationVC.swift
//  Zal_User
//
//  Created by Admin on 11/11/2023.
//

import UIKit

class NotificationVC: UIViewController,notificationProtocol {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func realoadData() {
        NotificationTabelView.reloadData()
    }
    
    func notifictionCount(count:Int){
        if count == 0 {
            NodataLabel.isHidden = false
        }else{
            NodataLabel.isHidden = true
        }
    }
    
    func selectcell(orderId:String,type:String,title:String,body:String){
        if type == "1" || type == "2" {
//            AuthService.instance.id = orderId
//            present(viewController: StoreTabbarVC())
//            DispatchQueue.global(qos: .background).async {
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                    // Put your code which should be executed with a delay here
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserOpenOrdersDetails"), object: nil)
//                }
//            }
    }else if type == "3" {
            let vc = Bundle.main.loadNibNamed("NotificationDetailsVC", owner: nil, options: nil)![0] as! NotificationDetailsVC
            vc.titleLabel.text = title
            vc.contentLabel.text = body
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBOutlet weak var NodataLabel: UILabel!
    @IBOutlet weak var NotificationTabelView: UITableView!{
        didSet {
            NotificationTabelView.delegate = self
            NotificationTabelView.dataSource = self
            NotificationTabelView.registerCell(withCellType: NotificationCell.self)
        }
    }
    
    var presenter : NotificationPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotificationPresenter(self)
        title = "Notification".localize
        presenter?.getnotification()
    }
    
    

}


extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = NotificationTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
        presenter?.didselect(index: indexPath.row)
    }
    
}


extension NotificationVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
}

