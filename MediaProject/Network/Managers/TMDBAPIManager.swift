//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 2/3/24.
//

import Foundation
import Alamofire

final class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    func fetchDataList<T: NetworkDataListModel>(decodingType: T.Type, api: TMDBAPIBase, completionHandler: @escaping ([TVSeriesModelProtocol]) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: decodingType) { response in
            switch response.result {
            case .success(let success):
                //print("success: \(success)")
                completionHandler(success.results)
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
    }
    
    func fetchData<T: Decodable>(decodingType: T.Type, api: TMDBAPIBase, completionHandler: @escaping (T) -> Void) {
        
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: api.headers)
        .responseDecodable(of: decodingType) { response in
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
