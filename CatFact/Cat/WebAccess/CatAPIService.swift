//
//  CatAPIService.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


import Foundation

import Foundation

protocol CatAPIServiceProtocol {
    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void)
    func fetchCatImage(completion: @escaping (Result<URL, Error>) -> Void)
}

class CatAPIService: CatAPIServiceProtocol {
    private let webService: WebServiceProtocol

    init(webService: WebServiceProtocol = WebServiceManager()) {
        self.webService = webService
    }

    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        webService.fetch(from: url) { (result: Result<CatFact, Error>) in
            switch result {
            case .success(let catFact):
                completion(.success(catFact.data.first ?? ""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchCatImage(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        webService.fetch(from: url) { (result: Result<[CatImage], Error>) in
            switch result {
            case .success(let imageResponses):
                if let imageUrlString = imageResponses.first?.url, let imageUrl = URL(string: imageUrlString) {
                    completion(.success(imageUrl))
                } else {
                    completion(.failure(NSError(domain: "No image URL", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
