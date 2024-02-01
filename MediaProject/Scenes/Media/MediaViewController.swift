//
//  MediaViewController.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MediaViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var trendingTVSeriesList: [TrendingTVSeries] = []
    private var topRatedTVSeriesList: [TopRatedTVSeries] = []
    private var popularTVSeriesList: [PopularTVSeries] = []

    private let tableViewTitleList = ["Trending", "Top Rated", "Popular"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        configureTableView()
        getData()
    }
    
    private func getData() {
        let dispathGroup = DispatchGroup()
        
        dispathGroup.enter()
        TrendingManager.shared.fetchTrendingTVSeries(api: .trending) { trendingTVSeriesList in
            self.trendingTVSeriesList = trendingTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        TopRatedManager.shared.fetchTopRatedTVSeries(api: .topRated) { topRatedTVSeriesList in
            self.topRatedTVSeriesList = topRatedTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        PopularManager.shared.fetchPopularTVSeries(api: .popular) { popularTVSeriesList in
            self.popularTVSeriesList = popularTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func goToDetailVC(with id: Int) {
        let dispatchGroup = DispatchGroup()
        
        var detail: DetailModel?
        var recommendedTVSeriesList: [RecommendedTVSeries]?
        var castMoel: AggregateCreditsModel?
        
        dispatchGroup.enter()
        DetailManager.shared.fetchTVSeriesDetails(api: .detail(id: id)) { detailModel in
            detail = detailModel
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        RecommendationsManager.shared.fetchRecommendedTVSeries(api: .recommendations(id: id)) {
            tvSeriesList in
            recommendedTVSeriesList = tvSeriesList
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        AggregateCreditsManager.shared.fetchTVSeriesCastings(api: .aggregateCredits(id: id)) { castingMoel in
            castMoel = castingMoel
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            let detailVC = DetailViewController()
            detailVC.tvSeriesDetails = detail
            detailVC.recommendedTVSeriesList = recommendedTVSeriesList ?? []
            detailVC.castModel = castMoel
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MediaViewController: UIViewControllerConfigurationProtocol {
    
    func configureConstraints() {
        [
            tableView
        ].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        
    }
}

extension MediaViewController: UITableViewConfigurationProtocol {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 204
        
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
    }
}

extension MediaViewController: UITableViewDelegate {
    
}

extension MediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: MediaCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        cell.titleLabel.text = tableViewTitleList[indexPath.row]
        return cell
    }
}

extension MediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var id: Int = 0
        if collectionView.tag == 0 {
            let tvSeries = trendingTVSeriesList[indexPath.item]
            id = tvSeries.id
        } else if collectionView.tag == 1 {
            let tvSeries = topRatedTVSeriesList[indexPath.item]
            id = tvSeries.id
        } else if collectionView.tag == 2 {
            let tvSeries = popularTVSeriesList[indexPath.item]
            id = tvSeries.id
        }
        
        goToDetailVC(with: id)
    }
}

extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingTVSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        
        if collectionView.tag == 0 {
            let tvSeries = trendingTVSeriesList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(tvSeries.backdropPath)")
            cell.backdropImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else if collectionView.tag == 1 {
            let tvSeries = topRatedTVSeriesList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(tvSeries.backdropPath)")
            cell.backdropImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else if collectionView.tag == 2 {
            let tvSeries = popularTVSeriesList[indexPath.item]
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
        
        return cell
    }
}
