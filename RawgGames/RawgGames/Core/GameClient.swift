//
//  Client.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import Foundation


import Foundation
import Alamofire
import UIKit

final class GameClient {
    static let BASE_URL = "https://api.rawg.io/api/"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
    
    static func getGames(completion: @escaping ([GameModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GetGamesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
   static func getGameDetail(gameId: Int, completion: @escaping (GameDetailModel?, Error?) -> Void) {
        let urlString = BASE_URL + "games/" + String(gameId) + "?key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GameDetailModel.self, completion: completion)
    }
    
    static func getGamesFromSameSeries(gameId: Int, completion: @escaping ([GameModel]?, Error?) -> Void) {

        let urlString = BASE_URL + "games/" + String(gameId) + "/game-series?key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GetGamesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getGamesBySearchText(searchText: String, completion: @escaping ([GameModel]?, Error?) -> Void) {
        guard let encodedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let urlString = BASE_URL + "games?search=" + encodedString + "&ordering=-rating" + "&key=" + Constants.API_KEY
        print(urlString)
        handleResponse(urlString: urlString, responseType: GetGamesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
    static func fetchImage(withUrlString urlString: String, completion: @escaping(UIImage)->()){
        print(urlString)
        guard let url  = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error =  error {
                print ("fetchin image error", error.localizedDescription)
                return
            }
            
            guard let data  = data  else {return}
            guard let image = UIImage(data: data) else {return}
    
            completion(image)
        }.resume()
    }
    
}
