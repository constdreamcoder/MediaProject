//
//  TopRatedManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Alamofire

final class TopRatedManager {
    static let shared = TopRatedManager()
    
    private init() {}
    
    func fetchTopRatedTVSeries(completionHandler: @escaping ([TopRatedTVSeries]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR&page=1"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: TopRatedModel.self) { response in
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
