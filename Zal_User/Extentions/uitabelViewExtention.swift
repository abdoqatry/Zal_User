//
//  uitabelViewExtention.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(withCellType: T.Type) where T: Reuseable {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<Base: UITableViewCell & Reuseable >(forIndexPath indexPath: IndexPath) -> Base {
        if let cell = self.dequeueReusableCell(withIdentifier: Base.reuseIdentifier, for: indexPath) as? Base {
            return cell
        } else {
            fatalError("can not dequeue cell with reusableIdentifier '\(Base.reuseIdentifier)' at indexPath '\(indexPath)'")
        }
    }
}


extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(withCellType: T.Type) where T: Reuseable {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<Base: UICollectionViewCell & Reuseable >(forIndexPath indexPath: IndexPath) -> Base {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: Base.reuseIdentifier, for: indexPath) as? Base {
            return cell
        } else {
            fatalError("can not dequeue cell with reusableIdentifier '\(Base.reuseIdentifier)' at indexPath '\(indexPath)'")
        }
    }
}
