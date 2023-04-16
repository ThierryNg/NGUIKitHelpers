//
//  ReusableCells.swift
//  NGUIKitHelpers
//
//  Created by Thierry on 2023/04/17.
//

import UIKit

public protocol ReusableCell: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: type(of: Self()))
    }
}

public extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        forIndexPath indexPath: IndexPath
    ) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("[ERROR] : Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

public extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        forIndexPath indexPath: IndexPath
    ) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("[ERROR] : Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
