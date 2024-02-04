//
//  UICollectionViewConfigurationProtocol.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit

protocol UICollectionViewConfigurationProtocol: AnyObject {
    func configureCollectionView()
    func configureCollectionViewLayout() -> UICollectionViewLayout
}
