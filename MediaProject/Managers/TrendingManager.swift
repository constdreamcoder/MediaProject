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
    
    func fetchTrendingTVSeries(api: TMDBAPIBase, completionHandler: @escaping ([TrendingTVSeries]) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: TrendingModel.self) { response in
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
