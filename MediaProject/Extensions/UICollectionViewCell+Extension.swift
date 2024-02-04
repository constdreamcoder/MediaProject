//
//  UICollectionViewCell+Extension.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit
import Kingfisher

extension UICollectionViewCell: IdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
    
    func getImage(_ cell: UICollectionViewCellBackdropImageViewConfigurationProtocol, tvSeries: TVSeriesModelProtocol) {
        if let backdropPath = tvSeries.backdropPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)")
            cell.backdropImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else if let posterPath = tvSeries.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
            cell.backdropImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            cell.backdropImageView.image = UIImage(systemName: "photo")
        }
    }
}
