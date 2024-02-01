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
    
    func fetchTopRatedTVSeries(api: TMDBAPIBase, completionHandler: @escaping ([TopRatedTVSeries]) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: TopRatedModel.self) { response in
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
