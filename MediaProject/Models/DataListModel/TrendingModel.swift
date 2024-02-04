//
//  TrendingModel.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import Foundation

struct TrendingModel: NetworkDataListModel {
    let page: Int
    let results: [TrendingTVSeries]
}

struct TrendingTVSeries: TVSeriesModelProtocol {
    let id: Int
    let name: String
    let originalName: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
