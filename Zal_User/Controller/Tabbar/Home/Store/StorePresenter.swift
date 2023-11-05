//
//  StorePresenter.swift
//  Zal_User
//
//  Created by Admin on 27/02/2023.
//

import Foundation

protocol StoreProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func errormassage(msg:String)
    
    func getdata(coverImage:String,profilImage:String,name:String,address:String,from:String,to:String,Open:Bool,days:String)
    
    func dataReload()
    
    func reloadProducts()
    
    func productHeight(count:Double)
    
    func addToCart(msg:String)
    
    func selectedProduct(id:String)
}

protocol CategoryCellView {
    func Data(name:String,Image:String)
   }

protocol ProductsCellView {
    func Data(name:String,Image:String,price:String,rate:Double,id:Int,is_liked:Bool)
   }

class StorePresenter {
    
    let vc: StoreProtocol
    
    init(_ controller: StoreProtocol) {
        vc = controller
    }
    
    var catStoreList : [CatDataModel] = []
    var productsList : [productsModel] = []
    
    func getStore(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(StoreModel.self, Requst: .get_provider(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                let storeData = Data?.data
                var days = ""
                
                for x in 0...(storeData?.days?.count ?? 0) - 1 {
                    days.append("\(storeData?.days?[x].name ?? "")," )
                }
                self?.vc.getdata(coverImage: storeData?.coverImage ?? "", profilImage: storeData?.image ?? "", name: storeData?.name ?? "", address: storeData?.address ?? "",from:storeData?.from ?? "",to:storeData?.to ?? "",Open:storeData?.is_open ?? false, days: days)
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func getStoreCategory(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CategoryModel.self, Requst: .product_categories, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.catStoreList = Data?.data ?? []
                let alltype : CatDataModel = CatDataModel(id: 0, name: "All".localize, image: "")
                self?.catStoreList.insert(alltype, at: 0)
                self?.vc.dataReload()
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func getProducts(catId:String,providerId:String,keyword:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProductsModel.self, Requst: .get_products(catId: catId, providerId: providerId, keyword: keyword), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productsList = Data?.data ?? []
                self?.vc.productHeight(count: Double(Data?.data?.count ?? 0))
                self?.vc.reloadProducts()
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func makeFavorite(index:Int,catId:String,providerId:String,keyword:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        let id = String(productsList[index].id ?? 0)
        NetworkManager.shared.getData(CategoryModel.self, Requst: .toggle_fav(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.getProducts(catId: catId, providerId: providerId, keyword: keyword)
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func storeCart(index:Int){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        let id = String(productsList[index].id ?? 0)
        NetworkManager.shared.getData(CartModel.self, Requst: .store_cart(id: id, quantity: "1"), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.vc.addToCart(msg: Data?.message ?? "")
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    let group = DispatchGroup()
    
    func callData(id:String){
        group.enter()
        getStore(id: id)
        group.leave()
        group.enter()
        getStoreCategory()
        group.leave()
    }
    
    func selectedType(index: Int)-> String{
        let id = String(catStoreList[index].id ?? 0)
        return id
    }
    
    func GetCategoryCount () -> Int{
        return  catStoreList.count
        }
    
    func configureType(cell: CategoryCellView, index: Int) {
        let data = catStoreList[index]
        let name = data.name ?? ""
        let Image = data.image ?? ""

        cell.Data(name: name, Image: Image)
       
        }
    
    func GetProductsCount () -> Int{
        return  productsList.count
        }
    
    func configureProducts(cell: ProductsCellView, index: Int) {
        let data = productsList[index]
        let name = data.name ?? ""
        let price = data.price ?? ""
        let rate = data.rate ?? 0.0
        let id = data.id ?? 0
        var Image = ""
        let liked = data.is_liked ?? false
        if data.images?.count != 0 {
            Image = data.images?.first?.image ?? ""
        }

        cell.Data(name: name, Image: Image, price: price, rate: rate, id: id, is_liked: liked)

        }
    
    func selectProduct(index: Int){
        let id = String(productsList[index].id ?? 0)
        self.vc.selectedProduct(id: id)
    }
    
}
