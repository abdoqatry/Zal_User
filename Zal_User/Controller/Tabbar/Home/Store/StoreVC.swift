//
//  StoreVC.swift
//  Zal_User
//
//  Created by Admin on 26/02/2023.
//

import UIKit
import Kingfisher

class StoreVC: UIViewController,StoreProtocol {
    func errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func getdata(coverImage: String, profilImage: String, name: String, address: String) {
        let url = URL(string: coverImage)
        let url2 = URL(string: profilImage)
        coveImage.kf.setImage(with: url)
        profileImage.kf.setImage(with: url2)
        shopNameLabel.text = name
        shopAddressLabel.text = address
    }
    
    func dataReload() {
        Categorycollection.reloadData()
    }
    
    func reloadProducts(){
        productCollectionView.reloadData()
    }
    
    func productHeight(count:Double){
        let item : Float = Float((count / 2.0))
        
        productcollectionHeight.constant = CGFloat((round(item) * 200) + 20 )
    }
    
    func addToCart(msg:String){
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func selectedProduct(id:String){
        let vc = Bundle.main.loadNibNamed("ProductDetailsVC", owner: nil, options: nil)![0] as! ProductDetailsVC
        vc.productid = id
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var productcollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var coveImage: UIImageView!
    @IBOutlet weak var productCollectionView: UICollectionView!{
        didSet {
            productCollectionView.delegate = self
            productCollectionView.dataSource = self
            productCollectionView.registerCell(withCellType: ProductionViewCell.self)
        }
    }
    @IBOutlet weak var Categorycollection: UICollectionView!{
        didSet {
            Categorycollection.delegate = self
            Categorycollection.dataSource = self
            Categorycollection.registerCell(withCellType: CategorycollectionCell.self)
        }
    }
    
    var currentSelected = 0
    var catId = ""
    var searchText = ""
    var id = ""
    
    var presenter : StorePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StorePresenter(self)
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter?.getStore(id: id)
        presenter?.callData(id: id)
    }
    
    func setView(){
        profileView.layer.cornerRadius = 60
        profileView.layer.applySketchShadow()
        profileImage.layer.cornerRadius = 60
        
    }
    
    func SingInAlert(){
        let alert = UIAlertController(title: "", message: "you have sign in first".localize, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler: { action in

                   }))
        alert.addAction(UIAlertAction(title: "Sing in".localize, style: .default, handler: { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
                      
                   self.navigationController?.pushViewController(LoginVC, animated: true)

                   }))
                   self.present(alert, animated: true, completion: nil)
          
      }

}



extension StoreVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == Categorycollection {
           return presenter?.GetCategoryCount() ?? 0
        }else{
            return presenter?.GetProductsCount() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == Categorycollection {
            let cell: CategorycollectionCell = Categorycollection.dequeueReusableCell(forIndexPath: indexPath)
            //        cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            
            
            
            if currentSelected == indexPath.row{
                cell.nameLabel.textColor = colorWithHexString(hexString: "#8B004C")
                cell.imageview.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
                catId = presenter?.selectedType(index: indexPath.row) ?? ""
                presenter?.getProducts(catId: catId, providerId: id)
            }else{
                cell.nameLabel.textColor = .gray
                cell.imageview.backgroundColor = .gray
            }
                    presenter?.configureType(cell: cell, index: indexPath.row)
            return cell
        }else{
            let cell: ProductionViewCell = productCollectionView.dequeueReusableCell(forIndexPath: indexPath)
            presenter?.configureProducts(cell: cell, index: indexPath.row)
            
            cell.favoriteProducte = {
                if AuthService.instance.authToken == nil || AuthService.instance.authToken == "" {
                    self.SingInAlert()
                        return
                    }
                self.presenter?.makeFavorite(index: indexPath.row, catId: self.catId, providerId: self.id )
            }
            cell.addToCartProducte = {
                if AuthService.instance.authToken == nil || AuthService.instance.authToken == "" {
                    self.SingInAlert()
                        return
                    }
                self.presenter?.storeCart(index: indexPath.row)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //add here
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == Categorycollection{
            return .init(width: 75, height: 100)
        }else{
            return .init(width: (view.frame.size.width / 2 - 10), height: 200)
        }
        
       }
    
}

extension StoreVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == Categorycollection {
            currentSelected = indexPath.row
            
            let text = searchTF.text ?? ""
            searchText = text
//            productCollectionView.reloadData()
            Categorycollection.reloadData()
        }else{
            presenter?.selectProduct(index: indexPath.row)
        }
    }
    
    
}

