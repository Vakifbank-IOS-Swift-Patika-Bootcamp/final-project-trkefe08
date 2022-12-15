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
    
    //MARK: - Request
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
    //MARK: - GameList Screen Methods
    func getGamesList(completion: @escaping (Result<GameListModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games?key=\(Constants.API_KEY)") else { return }
        makeRequest(url: url, completion: completion)
    }
    
    func getGamesListPage(with page: Int, completion: @escaping (Result<GameListModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games?key=\(Constants.API_KEY)&page=\(page)") else { return }
        makeRequest(url: url, completion: completion)
    }
    
    func searchGamesList(with search: String, with page: Int, completion: @escaping (Result<GameListModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games?key=\(Constants.API_KEY)&search=\(search)&page=\(page)") else { return }
        makeRequest(url: url, completion: completion)
    }
    
    func getPopularGamesList(completion: @escaping (Result<GameListModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games?key=\(Constants.API_KEY)&dates=2022-01-01,2022-12-31&ordering=-added") else { return }
        makeRequest(url: url, completion: completion)
    }
    //MARK: - GameDetail Screen Methods
    func getGameDetail(with id: Int, completion: @escaping (Result<GameDetailModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games/\(id)?key=\(Constants.API_KEY)") else { return }
        makeRequest(url: url, completion: completion)
    }
    
    func getOtherGameDetail(with id: Int, completion: @escaping (Result<GameSeriesModel?, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/games/\(id)/game-series?key=\(Constants.API_KEY)") else { return }
        makeRequest(url: url, completion: completion)
    }
}
