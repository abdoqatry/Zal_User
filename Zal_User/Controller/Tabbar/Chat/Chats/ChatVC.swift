//
//  ChatVC.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import UIKit
import IQKeyboardManagerSwift

class ChatVC: UIViewController,UITextViewDelegate{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ChatTable: UITableView!
    @IBOutlet weak var chatTV: UITextView!
    @IBOutlet weak var sendMsgBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var outSafeView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textChatView: UIView!
    
    private var keyboardHeight: CGFloat = 0.0

    var tableHeightContant: CGFloat = 0
    var increes : Int?

    let decoder = JSONDecoder()

    var textHeightConstraint: NSLayoutConstraint!
    private var firstTime = true

    var HasNext : String? = nil
      var isloading : Bool = false
      var last_page = 1
      var current_page = 1
    
    var id = ""
    var orderId = ""
    var RefrenceNum = ""
    var MassageArray = [Message]()
    var chatmodel : ChatData?
    
    lazy var refresher : UIRefreshControl = {
          let refresher = UIRefreshControl()
          refresher.tintColor = UIColor.blue
//        refresher.addTarget(self, action: #selector(self.LoadMore), for: .valueChanged)
          return refresher
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatTable.register(UINib(nibName: "ChatMessageCell", bundle: nil), forCellReuseIdentifier: "ChatMessageCell")
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
  //        title = "تفاصيل الطلب"

        ChatTable.backgroundView = nil
        ChatTable.tableFooterView = UIView()

        ChatTable.contentInset = .zero
        ChatTable.separatorColor = .clear
        chatTV.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        SetView()

         ChatTable.transform = CGAffineTransform(scaleX: 1, y: -1)

        GetData()

    }
    
    func SetView(){
        title = "Chat".localize
        textChatView.layer.cornerRadius = 12
        textChatView.layer.applySketchShadow()

    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if MassageArray.count != 0 {

        }
        if textView.text == "send massage" || textView.text == "اكتب رسالة" {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)

            let bottomOffset = CGPoint(x: 0, y: ChatTable.contentSize.height - ChatTable.bounds.size.height)
//            ChatTable.setContentOffset(bottomOffset, animated: true)
//             self.view.layoutIfNeeded()

        }
          let bottomOffset = CGPoint(x: 0, y: ChatTable.contentSize.height - ChatTable.bounds.size.height)
          ChatTable.setContentOffset(bottomOffset, animated: true)
           self.view.layoutIfNeeded()
    }

func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            textView.text = "اكتب رسالة"
            textView.textColor = UIColor.gray
    }
   
}

func textViewDidChange(_ textView: UITextView) {
    self.refresher.isHidden = true

    if textView.text.isEmpty{
        //            textView.textColor = UIColor.lightGray

        textView.text = ""
        sendBtn.isEnabled = false
        scrollToBottom()
        self.view.layoutIfNeeded()
    }
    else{
        sendBtn.isEnabled = true
    }

    scrollToBottom()
    self.view.layoutIfNeeded()

}

@objc private func chatTapped() {
     self.view.endEditing(true)
    self.refresher.endRefreshing()
     self.scrollToBottom()
 }
    
    @objc func keyboardWillHide(notification: NSNotification) {

        if sendMsgBottomConstraint.constant != 0 {
       sendMsgBottomConstraint.constant = 0
      refresher.endRefreshing()
      refresher.isHidden = true
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            keyboardHeight = keyboardSize.height
            sendMsgBottomConstraint.constant = (1 * (keyboardHeight - 60))
            print(keyboardSize.height)
           self.scrollToBottom()
            self.view.layoutIfNeeded()


          }
      }

    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.MassageArray.count != 0 {
            self.ChatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func GetData(){
       self.refresher.endRefreshing()
       guard !isloading else {return}
    openIndicator(title: Constants.PLEASE_WAIT, description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ChatModel.self, Requst: .chatsgetMessages(page: String(current_page), id: orderId),method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
        self?.closeIndicator()
        if Code == 200 {
            if let data = Data {

//                self?.MassageArray = data.messages ?? [Message]
//            self?.HasNext = data.links?.next ?? nil
            self?.current_page = 1
                self?.MassageArray = data.data?.messages ?? []
                guard let chatModel = data.data  else {return}
                self?.chatmodel = chatModel
//               if data.hasNext == false{
//                   self?.refresher.endRefreshing()
//               }
                
               self?.ChatTable.reloadData()
                
                if self?.MassageArray.count != 0 {
             self?.scrollToBottom()
                }
               self?.view.layoutIfNeeded()
            }
        }else {
//            let msg = Data?.message ?? ""
//           self?.showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
        }

    }
    
        
    }

    func SendMessage(){
        
        view.endEditing(true)
//        let id = AuthService.instance.userType ?? 0
        let text = chatTV.text ?? ""
        let message: Message = Message(id: "", msg: text, msgType: nil, senderType: nil, readAt: nil, createdAt: nil, sending: true)
        self.MassageArray.insert(message, at: 0)
         self.ChatTable.reloadData()
        scrollToBottom()
        self.view.layoutIfNeeded()
        self.chatTV.text = ""
        
        NetworkManager.shared.getData(ChatModel.self, Requst: .SendMessage(order_id: orderId, msg: text, msg_type: "text"),method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
 //        self?.closeIndicator()
         if Code == 200 {
            
//            self?.GetData()
            print("Succed Send")
        }else if Code == 401{
                AuthService.instance.Logout()
        }else{
    self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
                    }
                }
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
    
        guard chatTV.text != "اكتب رسالة" else{return}
        guard chatTV.text != "" else{return}
        guard chatTV.text != "send massage" else{return}
        
            SendMessage()
      
    }
    

}



extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         if HasNext == nil {
            self.refresher.endRefreshing()
            self.refresher.isHidden = true
        }
    
        
        
        let cell = ChatTable.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        
        cell.selectionStyle = .none
        
        if MassageArray[indexPath.row].senderType == "user" || MassageArray[indexPath.row].sending == true{
           
//            if MassageArray[indexPath.row].sending == true {
//                cell.sendingLabel.text = "....جار الارسال".localize
//                }else{
//                cell.sendingLabel.text = ""
//            }
            
           
//
            let pho = chatmodel?.user?.image ?? ""
            cell.awayLabel.isHidden = false
            cell.awayPhoto.isHidden = false
            cell.AwayView.isHidden = false
            cell.AwayViewContent.isHidden = false
            
            cell.MessageHomeView.isHidden = true
            cell.HomeView.isHidden = true
            cell.homeImage.isHidden = true
            cell.contentLabel.isHidden = true
            cell.awayPhoto.downloaded(from: pho)
            cell.awayLabel.text = MassageArray[indexPath.row].msg ?? ""
        }else{
         
            let pho = chatmodel?.provider?.image ?? ""
            cell.awayLabel.isHidden = true
            cell.awayPhoto.isHidden = true
            cell.AwayView.isHidden = true
            cell.AwayViewContent.isHidden = true
            cell.MessageHomeView.isHidden = false
            cell.HomeView.isHidden = false
            cell.homeImage.isHidden = false
            cell.contentLabel.isHidden = false
            
            cell.homeImage.downloaded(from: pho)
            cell.contentLabel.text = MassageArray[indexPath.row].msg ?? ""
        }

      
        
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
            
        }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.MassageArray.count
        if indexPath.row == count-1{
//              self.ChatTable.endUpdates()
//            self.ChatTable.layer.removeAllAnimations()
//            LoadMore()
        }
    }
        
        
        
    }
    
