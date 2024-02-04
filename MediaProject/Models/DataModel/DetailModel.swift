//
//  DetailModel.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Foundation

struct DetailModel: Decodable {
    let id: Int
    let name: String
    let originalName: String
    let overview: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case overview
        case backdropPath = "backdrop_path"
    }
}
