//
//  MockCatAPIService.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//

import XCTest
import Foundation
@testable import CatFact

class MockCatAPIService1: CatAPIServiceProtocol {
    var catFact: String!
    var catImageUrl: URL!
    var shouldFail: Bool = false

    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Something webt wrong", code: -1, userInfo: nil)))
        } else {
            completion(.success(catFact))
        }
    }
    
    func fetchCatImage(completion: @escaping (Result<URL, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Something went wrong", code: -1, userInfo: nil)))
        } else {
            completion(.success(catImageUrl))
        }
    }
}

class MockWebService: WebServiceProtocol {
    var shouldReturnError: Bool = false
    var result: Result<Any, Error>!
    
    func fetch<T>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldReturnError {
            completion(.failure(NSError(domain: "Mock Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Forced failure in mock service"])))
        } else if let unwrappedResult = result as? Result<T, Error> {
            completion(unwrappedResult)
        } else {
            completion(.failure(NSError(domain: "Mock Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid result type"])))
        }
    }
}

