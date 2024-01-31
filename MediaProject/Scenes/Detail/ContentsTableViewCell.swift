//
//  ContentsTableViewCell.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 2/1/24.
//

import UIKit
import SnapKit

class ContentsTableViewCell: UITableViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "김감독"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let castTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출연"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.text = "김배우, 이배우, 정배우"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let recommendationsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 작품"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    lazy var recommendedTVSeriesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        [
            nameLabel,
            overviewLabel,
            directorTitleLabel,
            directorLabel,
            castTitleLabel,
            castLabel,
            separatorView,
            recommendationsTitleLabel,
            recommendedTVSeriesCollectionView
        ].forEach { contentView.addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalTo(nameLabel)
        }
        
        directorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(overviewLabel)
        }
        
        directorTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        directorTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(directorTitleLabel)
            $0.leading.equalTo(directorTitleLabel.snp.trailing).offset(32.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        castTitleLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(directorTitleLabel)
        }
        
        castTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        castTitleLabel.setContentHuggingPriority(.required, for: .horizontal)

        castLabel.snp.makeConstraints {
            $0.top.equalTo(castTitleLabel)
            $0.leading.equalTo(castTitleLabel.snp.trailing).offset(32.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalToSuperview().inset(8.0)
            $0.height.equalTo(1.0)
        }
        
        recommendationsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalToSuperview().inset(8.0)
        }
        
        recommendedTVSeriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendationsTitleLabel.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}

extension ContentsTableViewCell: UICollectionViewConfigurationProtocol {
    func configureCollectionView() {
        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
