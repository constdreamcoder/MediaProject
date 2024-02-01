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
    
    func fetchPopularTVSeries(api: TMDBAPIBase, completionHandler: @escaping ([PopularTVSeries]) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: PopularModel.self) { response in
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
