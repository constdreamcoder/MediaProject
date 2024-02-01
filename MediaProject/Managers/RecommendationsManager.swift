//
//  RecommendationsManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Alamofire

final class RecommendationsManager {
    static let shared = RecommendationsManager()
    
    private init() {}
    
    func fetchRecommendedTVSeries(api: TMDBAPIBase, completionHandler: @escaping ([RecommendedTVSeries]) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: RecommendationsModel.self) { response in
            switch response.result {
            case .success(let success):
                //print("success: \(success)")
                completionHandler(success.results)
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
    }
}
