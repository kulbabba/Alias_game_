//
//  UICollectionView+Extensions.swift
//  Alias
//
//  Created by Oleg Ivaniv on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

// swiftlint:disable line_length
protocol ViewIdentifiable {
    static var viewIdentifier: String { get }
}

// MARK: - Default conformations

extension ViewIdentifiable where Self: UIViewController {
    static var viewIdentifier: String { return String(describing: self) }
}

extension ViewIdentifiable where Self: UIView {
    static var viewIdentifier: String { return String(describing: self) }
}

extension UIViewController: ViewIdentifiable {}
extension UITableViewCell: ViewIdentifiable {}
extension UICollectionReusableView: ViewIdentifiable {}
extension UITableViewHeaderFooterView: ViewIdentifiable {}

// MARK: - Dequeuing Cells

extension UICollectionView {

    /**
     Returns a reusable cell object located by its identifier.

     Usage:
     ````
     let cell: ImageCollectionCell = collectionView.dequeueReusableCell(at: indexPath)
     cell.setImage(withURL: items[indexPath.item].url)
     return cell
     ````
     - Parameters:
     - indexPath: The index path specifying the location of the cell
     - identifier: cell reuse identifier. Default value equals to cell class name
     - returns: Collection view cell with specified identifier casted to T or fatalError if cast is not possible or there is no cell with specified identifier
     */
    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.viewIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }
}

extension UITableView {

    /**
     Returns a reusable table view cell object for the specified reuse identifier and adds it to the table.

     Usage:
     ````
     let cell: PersonCollectionCell = tableView.dequeueReusableCell(at: indexPath)
     cell.configure(with: items[indexPath.row]
     return cell
     ````
     - Parameters:
     - indexPath: The index path specifying the location of the cell
     - identifier: cell reuse identifier. Default value equals to cell class name
     - returns: Table view cell with specified identifier casted to T or fatalError if cast is not possible or there is no cell with specified identifier
     */
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.viewIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }

    /**
     Returns a reusable header or footer view located by its identifier.

     Usage:
     ````
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let header: RequestStepTableSectionHeaderView = tableView.dequeueReusableHeaderFooterView()
     header.configure(with: items[section])
     return header
     }
     ````
     - parameter identifier: HeaderFooterView reuse identifier. Default value equals to view class name
     - returns: Table view HeaderFooterView object with specified identifier casted to T or fatalError if cast is not possible or there is no view with specified identifier
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = T.viewIdentifier) -> T {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("There is no header/footer with \(identifier) identifier")
        }

        return header
    }
}

// MARK: - Registering

extension UITableView {

    /**
     Registers a class for use in creating new table cells.
     - Parameters:
     - class: The class of a cell that you want to use in the table
     - identifier: Cell reuse identifier. Default value equals to cell class name
     */
    func register<T: UITableViewCell>(class aClass: T.Type, identifier: String = T.viewIdentifier) {
        register(aClass, forCellReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating new table header or footer views.
     - Parameters:
     - class: The class of a headerFooterView that you want to use in the table
     - identifier: View reuse identifier. Default value equals to view class name
     */
    func register<T: UITableViewHeaderFooterView>(class aClass: T.Type, identifier: String = T.viewIdentifier) {
        register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    /**
     Registers a class for use in creating new collection view cells.
     - Parameters:
     - class: The class of a cell that you want to use in the collection view
     - identifier: Cell reuse identifier. Default value equals to cell class name
     */
    func register<T: UICollectionViewCell>(class aClass: T.Type, identifier: String = T.viewIdentifier) {
        register(aClass, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    /**
     Enum Wrapper for UICollectionElementKindSectionHeader/Footer
     */
    enum ElementKind {
        case header, footer

        fileprivate var name: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {

    /**
     Registers a class for use in creating supplementary views for the collection view.
     - Parameters:
     - class: The class of a headerFooterView that you want to use in the table
     - elementKind: The kind of supplementary view to create
     - identifier: View reuse identifier. Default value equals to view class name
     */
    func register<T: UICollectionReusableView>(class aClass: T.Type, elementKind kind: ElementKind, identifier: String = T.viewIdentifier) {
        register(aClass, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }
}

