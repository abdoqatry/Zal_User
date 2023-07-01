//
//  FavoriteVC.swift
//  Zal_User
//
//  Created by Admin on 12/03/2023.
//

import UIKit

class FavoriteVC: UIViewController,FavoriteProtocol {
    func errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func dataReload() {
        favoriteProductCollectionView.reloadData()
    }
    

    @IBOutlet weak var favoriteProductCollectionView: UICollectionView!{
        didSet {
            favoriteProductCollectionView.delegate = self
            favoriteProductCollectionView.dataSource = self
            favoriteProductCollectionView.registerCell(withCellType: FavoriteCell.self)
        }
    }
    
    var presenter : FavoritePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(self)
        presenter?.getProducts()
        title = "My Favorite".localize
    }
    
    

}



extension FavoriteVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter?.GetProductsCount() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: FavoriteCell = favoriteProductCollectionView.dequeueReusableCell(forIndexPath: indexPath)
            presenter?.configureProducts(cell: cell, index: indexPath.row)
            
            cell.favoriteProducte = {
                self.presenter?.makeFavorite(index: indexPath.row)
            }
            
            return cell
        
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
       
            return .init(width: (view.frame.size.width / 2 - 10), height: 200)
        }
        
    
}

extension FavoriteVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
            let vc = Bundle.main.loadNibNamed("ProductDetailsVC", owner: nil, options: nil)![0] as! ProductDetailsVC
            vc.productid = "2"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    
    
}


