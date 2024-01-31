//
//  MediaCollectionViewCell.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit
import SnapKit

final class MediaCollectionViewCell: UICollectionViewCell {
    
    let backdropImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        contentView.addSubview(backdropImageView)
        backdropImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    private func configureUI() {
        backgroundColor = .blue

    }
}
