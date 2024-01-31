//
//  RecommendedTVSeriesCollectionViewCell.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import UIKit
import SnapKit

class RecommendedTVSeriesCollectionViewCell: UICollectionViewCell {
    let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    let originalNameLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        [
            backdropImageView,
            originalNameLabel
        ].forEach { contentView.addSubview($0) }
        
        backdropImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
        }
        
        originalNameLabel.snp.makeConstraints {
            $0.top.equalTo(backdropImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.height.equalTo(20.0)
        }
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 8.0
    }
}
