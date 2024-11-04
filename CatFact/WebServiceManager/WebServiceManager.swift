//
//  WebServiceManager.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


import Foundation

import Foundation

protocol WebServiceProtocol {
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}


class WebServiceManager: WebServiceProtocol {
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            // Decode the data
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
