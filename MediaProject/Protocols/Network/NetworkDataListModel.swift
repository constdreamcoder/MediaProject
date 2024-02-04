//
//  NetworkDataListModel.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 2/3/24.
//

import Foundation

protocol NetworkDataListModel: Decodable {
    
    associatedtype ResultType: TVSeriesModelProtocol
    
    var page: Int { get }
    var results: [ResultType] { get }
}

protocol TVSeriesModelProtocol: Decodable {
    var id: Int { get }
    var name: String { get }
    var originalName: String { get }
    var overview: String { get }
    var backdropPath: String? { get }
    var posterPath: String? { get }
}
