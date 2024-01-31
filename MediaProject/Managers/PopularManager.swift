//
//  PopularManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Alamofire

final class PopularManager {
    static let shared = PopularManager()
    
    private init() {}
    
    func fetchPopularTVSeries(completionHandler: @escaping ([PopularTVSeries]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/popular?language=ko-KR&page=1"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: PopularModel.self) { response in
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
