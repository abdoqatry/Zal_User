//
//  MessageVC.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import UIKit

class MessageVC: UIViewController,MessageListProtocol {
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func realoadData() {
        MessagetionTabelView.reloadData()
    }
    

    @IBOutlet weak var MessagetionTabelView: UITableView!{
        didSet {
            MessagetionTabelView.delegate = self
            MessagetionTabelView.dataSource = self
            MessagetionTabelView.registerCell(withCellType: MessagelistCell.self)
        }
    }
    
    func selectCell(id:String,orderId:String){
        let VC = Bundle.main.loadNibNamed("ChatVC", owner: nil, options: nil)![0] as! ChatVC
        VC.id = id
        VC.orderId = orderId
        navigationController?.pushViewController(VC, animated: true)
    }
    var presenter : MessageListPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MessageListPresenter(self)
       
        title = "Chat".localize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getMessageList()
    }
    
    

}



extension MessageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessagelistCell = MessagetionTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didselectCell(index: indexPath.row)
    }
    
}


extension MessageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}
