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

    /**
     * Get our suburbs data from api and pass a result set to our completion block containing the list of suburbs
     * or an error if encountered
     *
     * - Parameters:
     *   - completion: Pass result set with either the list of suburbs or error if encountered
     */
    func getSuburbs(completion: @escaping (Result<[Suburb], NPError>) -> Void) {
        //if url can't be accessed
        guard let url = URL(string: baseUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //if error is present
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            //if urlResponse is not OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //if data is nil
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                //use our intermediary structure to decode the list of suburbs
                let jsonSuburbs = try decoder.decode(Suburbs.self, from: data)
                let suburbs = jsonSuburbs.data
                
                completion(.success(suburbs))
            } catch {
                //if there's an issue in decoding
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
}
