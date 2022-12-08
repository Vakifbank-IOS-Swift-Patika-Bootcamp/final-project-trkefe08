//
//  RawgDBClient.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import Foundation

final class RawgDBClient {
    
    static let shared = RawgDBClient()
    private init() {}
    
    //MARK: Methods
    func makeRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // TODO: error case
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getGamesList(completion: @escaping (Result<[GameListResultModel]?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL + Constants.API_KEY)/games") else { return }
        makeRequest(url: url, completion: completion)
    }
}
