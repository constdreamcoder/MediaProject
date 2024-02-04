//
//  PopularModel.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Foundation

struct PopularModel: NetworkDataListModel {
    let page: Int
    let results: [PopularTVSeries]
}

struct PopularTVSeries: TVSeriesModelProtocol {
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
