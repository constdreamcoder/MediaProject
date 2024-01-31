//
//  AggregateCreditsManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Alamofire

final class AggregateCreditsManager {
    static let shared = AggregateCreditsManager()
    
    private init() {}
    
    func fetchTVSeriesCastings(id: Int, completionHandler: @escaping (AggregateCreditsModel) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/\(id)/aggregate_credits?language=ko-KR"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: AggregateCreditsModel.self) { response in
                switch response.result {
                case .success(let success):
//                    print("success: \(success)")
                    completionHandler(success)
                case .failure(let failure):
                    print("failure: \(failure)")
                }
            }
    }
}
