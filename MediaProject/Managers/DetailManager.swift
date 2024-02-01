//
//  DetailManager.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 1/31/24.
//

import Alamofire

final class DetailManager {
    static let shared = DetailManager()
    
    private init() {}
    
    func fetchTVSeriesDetails(api: TMDBAPIBase, completionHandler: @escaping (DetailModel) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: DetailModel.self) { response in
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
