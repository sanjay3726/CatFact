//
//  CatFactTests.swift
//  CatFactTests
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//

import Testing
import Foundation
@testable import CatFact


class MockCatAPIService: CatAPIService {
    var shouldReturnError = false
    var mockFact = "Cats sleep for 70% of their lives."
    var mockImageUrl = URL(string: "https://example.com/cat.jpg")!
    
    override func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load fact"])))
        } else {
            completion(.success(mockFact))
        }
    }
    
    override func fetchCatImage(completion: @escaping (Result<URL, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])))
        } else {
            completion(.success(mockImageUrl))
        }
    }
}

