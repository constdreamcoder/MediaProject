//
//  TrendingManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/30/24.
//

import Alamofire

final class TrendingManager {
    static let shared = TrendingManager()
    
    private init() {}
    
    func fetchTrendingTVSeries(completionHandler: @escaping ([TrendingTVSeries]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/trending/tv/day?language=ko-KR"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: TrendingModel.self) { response in
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
