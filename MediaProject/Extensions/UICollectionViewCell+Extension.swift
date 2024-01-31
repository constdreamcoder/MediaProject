//
//  UICollectionViewCell+Extension.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit

extension UICollectionViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
