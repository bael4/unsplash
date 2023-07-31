//
//  NetworkManager.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import Foundation

class NetworkManager {
    
    static let networkManager = NetworkManager()
    
    func getImages<T: Decodable>(_ url: String, type: T.Type, complition: @escaping (Bool, [T]) -> ()) {
        guard let url = URL(string: url) else {
            complition(false, [])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        let accessKey = APIConfig.unsplashAccessKey
        urlRequest.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
    
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error)
                complition(false, [])
            }
            
            guard let data = data else {
                complition(false, [])
                return
            }
            
            do {
                let parsaData = try JSONDecoder().decode([T].self, from: data)
                complition(true, parsaData)
            }
            catch {
                print(error.localizedDescription)
                complition(false, [])
            }
        }.resume()
    }
}
