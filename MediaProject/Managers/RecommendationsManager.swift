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
    
    func fetchRecommendedTVSeries(id: Int, completionHandler: @escaping ([RecommendedTVSeries]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/\(id)/recommendations?language=ko-KR"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: RecommendationsModel.self) { response in
                switch response.result {
                case .success(let success):
//                    print("success: \(success)")
                    completionHandler(success.results)
                case .failure(let failure):
                    print("failure: \(failure)")
                }
            }
    }
}
