//
//  UITableViewCell+Extension.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit

extension UITableViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
