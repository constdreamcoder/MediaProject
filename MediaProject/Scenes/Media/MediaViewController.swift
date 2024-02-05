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
    
    private var tvSeriesList: [[TVSeriesModelProtocol]] = Array<[TVSeriesModelProtocol]>(repeating: [], count: 3)

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
        TMDBAPIManager.shared.fetchDataList(decodingType: TrendingModel.self, api: .trending) { trendingTVSeriesList in
            self.tvSeriesList[0] = trendingTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        TMDBAPIManager.shared.fetchDataList(decodingType: TopRatedModel.self, api: .topRated) { topRatedTVSeriesList in
            self.tvSeriesList[1] = topRatedTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.enter()
        TMDBAPIManager.shared.fetchDataList(decodingType: PopularModel.self, api: .popular) { popularTVSeriesList in
            self.tvSeriesList[2] = popularTVSeriesList
            dispathGroup.leave()
        }
        
        dispathGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func goToDetailVC(with id: Int) {
        let dispatchGroup = DispatchGroup()
        
        var detail: DetailModel?
        var recommendedTVSeriesList: [TVSeriesModelProtocol]?
        var castMoel: AggregateCreditsModel?
        
        dispatchGroup.enter()
        TMDBAPIURLSession.shared.fetchData(decodingType: DetailModel.self, api: .detail(id: id)) { detailModel, error in
            
            if error == nil {
                guard let detailModel = detailModel else { return }
                detail = detailModel
            } else {
                print(error!)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        TMDBAPIURLSession.shared.fetchDataList(decodingType: RecommendationsModel.self, api: .recommendations(id: id)) {
            tvSeriesList, error  in
            
            if error == nil {
                guard let tvSeriesList = tvSeriesList else { return }
                recommendedTVSeriesList = tvSeriesList
            } else {
                print(error!)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        TMDBAPIURLSession.shared.fetchData(decodingType: AggregateCreditsModel.self, api: .aggregateCredits(id: id)) { castingMoel, error in
           
            if error == nil {
                guard let castingMoel = castingMoel else { return }
                castMoel = castingMoel
            } else {
                print(error!)
            }
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
        
        let tvSeries = tvSeriesList[collectionView.tag][indexPath.item]
        id = tvSeries.id
        
        goToDetailVC(with: id)
    }
}

extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeriesList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as! MediaCollectionViewCell
        
        let tvSeries = tvSeriesList[collectionView.tag][indexPath.item]
        cell.getImage(cell, tvSeries: tvSeries)

        return cell
    }
}
