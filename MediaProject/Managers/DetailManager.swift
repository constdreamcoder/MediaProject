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
    
    func fetchTVSeriesDetails(id: Int, completionHandler: @escaping (DetailModel) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/\(id)?language=ko-KR"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKeys.tmdb
        ]
        
        AF.request(urlString, headers: headers)
            .responseDecodable(of: DetailModel.self) { response in
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
