//
//  TMDBAPIBase.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBAPIBase {
    case trending
    case topRated
    case popular
    case detail(id: Int)
    case recommendations(id: Int)
    case aggregateCredits(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": APIKeys.tmdb]
    }
    
    var parameters: Parameters {
        switch self {
        case .trending:
            return ["language": "ko-KR"]
        case .topRated:
            return ["language": "ko-KR", "page": "1"]
        case .popular:
            return ["language": "ko-KR", "page": "1"]
        case .detail:
            return ["language": "ko-KR"]
        case .recommendations:
            return ["language": "ko-KR"]
        case .aggregateCredits:
            return ["language": "ko-KR"]
        }
    }
    
    var endpoint: String {
        switch self {
        case .trending:
            return baseURL + "/trending/tv/day"
        case .topRated:
            return baseURL + "/tv/top_rated"
        case .popular:
            return baseURL + "/tv/popular"
        case .detail(let id):
            return baseURL + "/tv/\(id)"
        case .recommendations(let id):
            return baseURL + "/tv/\(id)/recommendations"
        case .aggregateCredits(let id):
            return baseURL + "/tv/\(id)/aggregate_credits"
        }
    }
}
