//
//  TMDBAPIURLSession.swift
//  MediaProject
//
//  Created by SUCHAN CHANG on 2/5/24.
//

import Foundation
import Alamofire

final class TMDBAPIURLSession {
    static let shared = TMDBAPIURLSession()
    
    private init() {}

    func fetchDataList<T: NetworkDataListModel>(decodingType: T.Type, api: TMDBAPIBase, completionHandler: @escaping ([TVSeriesModelProtocol]?, NetworkError?) -> Void) {
        
        URLSession.shared.dataTask(with: configureURLRequest(with: api)) { data, response, error in
            
            guard error == nil else {
                print("네트워크 오류 발생")
                completionHandler(nil, .faildRequest)
                return
            }
            
            guard let data = data else {
                print("통신은 됐지만 데이터가 안옴")
                completionHandler(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse  else {
                print("통신은 성공했지만 응답값이 오지 않음")
                completionHandler(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("통신은 성공했지만 올바른 값이 오지 않음")
                completionHandler(nil, .faildRequest)
                return
            }
            
            do {
                let decodedResults = try JSONDecoder().decode(decodingType, from: data)
                completionHandler(decodedResults.results, nil)
            } catch {
                completionHandler(nil, .invalidData)
                print(error)
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(decodingType: T.Type, api: TMDBAPIBase, completionHandler: @escaping (T?, NetworkError?) -> Void) {
        
        URLSession.shared.dataTask(with: configureURLRequest(with: api)) { data, response, error in
            
            guard error == nil else {
                print("네트워크 오류 발생")
                completionHandler(nil, .faildRequest)
                return
            }
            
            guard let data = data else {
                print("통신은 됐지만 데이터가 안옴")
                completionHandler(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse  else {
                print("통신은 성공했지만 응답값이 오지 않음")
                completionHandler(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("통신은 성공했지만 올바른 값이 오지 않음")
                completionHandler(nil, .faildRequest)
                return
            }
            
            do {
                let decodedResults = try JSONDecoder().decode(decodingType, from: data)
                completionHandler(decodedResults, nil)
            } catch {
                completionHandler(nil, .invalidData)
                print(error)
            }
        }.resume()
    }
}

// MARK: - Custom Methods
private extension TMDBAPIURLSession {
    func configureURLRequest(with api: TMDBAPIBase) -> URLRequest {
        var urlComponents = URLComponents(string: api.endpoint)
        
        urlComponents?.queryItems = []
        
        api.parameters.keys.forEach { key in
            guard let value = api.parameters[key] as? String else { return }
            let query = URLQueryItem(name: key, value: value)
            urlComponents?.queryItems?.append(query)
        }
        
        guard let url = urlComponents?.url else { return URLRequest(url: URL(string: "")!) }
        var urlRequest = URLRequest(url: url)
        
        api.headers.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }
        
        return urlRequest
    }
}
