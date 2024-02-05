//
//  DetailViewController.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    lazy var contentsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContentsTableViewCell.self, forCellReuseIdentifier: ContentsTableViewCell.identifier)
        
        return tableView
    }()
    
    var tvSeriesDetails: DetailModel?
    var recommendedTVSeriesList: [TVSeriesModelProtocol] = []
    var castModel: AggregateCreditsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureConstraints()
        configureUI()
    }
}

extension DetailViewController: UIViewControllerConfigurationProtocol {
    
    func configureNavigationBar() {
        guard let originalName = tvSeriesDetails?.originalName else { return }
        navigationItem.title = originalName
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
    }
    
    func configureConstraints() {
        [
            backdropImageView,
            contentsTableView
        ].forEach { view.addSubview($0) }
        
        backdropImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        contentsTableView.snp.makeConstraints {
            $0.top.equalTo(backdropImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .black
        
        guard let detail = tvSeriesDetails else { return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(detail.backdropPath)")
        backdropImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedTVSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTVSeriesCollectionViewCell.identifier, for: indexPath) as! RecommendedTVSeriesCollectionViewCell
        
        let tvSeries = recommendedTVSeriesList[indexPath.item]
        cell.getImage(cell, tvSeries: tvSeries)
        
        cell.originalNameLabel.text = tvSeries.originalName
        
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentsTableViewCell.identifier, for: indexPath) as! ContentsTableViewCell
        
        cell.recommendedTVSeriesCollectionView.delegate = self
        cell.recommendedTVSeriesCollectionView.dataSource = self
        
        cell.recommendedTVSeriesCollectionView.register(RecommendedTVSeriesCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTVSeriesCollectionViewCell.identifier)
        
        guard let detail = tvSeriesDetails else { return UITableViewCell() }

        cell.nameLabel.text = detail.name
        cell.overviewLabel.text = detail.overview
        
        guard let castModel = castModel else { return UITableViewCell() }
        let directorNameList = castModel.crew.map { $0.originalName }
        if directorNameList.count > 0 {
            cell.directorLabel.text = directorNameList[0]
        } else {
            cell.directorLabel.text = "미등록됨"
        }
        
        let castOriginalNameList = Array(castModel.cast.map { $0.originalName }[0..<4])
        cell.castLabel.text = castOriginalNameList.joined(separator: ", ")
        return cell
    }
}
