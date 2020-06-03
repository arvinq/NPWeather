//
//  NetworkManager.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "http://dnu5embx6omws.cloudfront.net/venues/weather.json"
    
    private init() { }
    
    func getSuburbs(completion: @escaping (Result<[Suburb], NPError>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let jsonSuburbs = try decoder.decode(Suburbs.self, from: data)
                let suburbs = jsonSuburbs.data
                
                completion(.success(suburbs))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
}
