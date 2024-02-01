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
    
    func fetchTVSeriesCastings(api: TMDBAPIBase, completionHandler: @escaping (AggregateCreditsModel) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: AggregateCreditsModel.self) { response in
            switch response.result {
            case .success(let success):
                //print("success: \(success)")
                completionHandler(success)
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
    }
}
