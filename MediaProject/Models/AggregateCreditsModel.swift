//
//  AggregateCreditsModel.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Foundation

struct AggregateCreditsModel: Decodable {
    let id: Int
    let cast: [Actor]
    let crew: [Crew]
}

struct Actor: Decodable {
    let id: Int
    let name: String
    let originalName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
    }
}

struct Crew: Decodable {
    let id: Int
    let name: String
    let originalName: String
    let department: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case department
    }
}

