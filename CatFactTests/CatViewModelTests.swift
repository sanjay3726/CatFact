//
//  CatViewModelTests.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//

import Testing
import Foundation
@testable import CatFact
import XCTest

class CatViewModelTests: XCTestCase {
    
    var viewModel: CatViewModel!
    var mockService: MockCatAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCatAPIService()
        viewModel = CatViewModel(apiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchCatContent_SuccessfulResponse() {
        // Expectations
        let factExpectation = expectation(description: "Fetch fact successful")
        let imageExpectation = expectation(description: "Fetch image successful")
        
        viewModel.onFactFetched = { fact in
            XCTAssertEqual(fact, "Cats sleep for 70% of their lives.")
            factExpectation.fulfill()
        }
        
        viewModel.onImageFetched = { imageUrl in
            XCTAssertEqual(imageUrl, URL(string: "https://example.com/cat.jpg"))
            imageExpectation.fulfill()
        }
        
        viewModel.fetchCatContent()
        
        wait(for: [factExpectation, imageExpectation], timeout: 1.0)
    }
    
    func testFetchCatFact_SuccessfulResponse() {
        // Expectation
        let factExpectation = expectation(description: "Fetch fact successful")
        
        viewModel.onFactFetched = { fact in
            XCTAssertEqual(fact, "Cats sleep for 70% of their lives.")
            factExpectation.fulfill()
        }
        
        viewModel.fetchCatContent()
        
        wait(for: [factExpectation], timeout: 1.0)
    }
    
    func testFetchCatImage_SuccessfulResponse() {
        // Expectation
        let imageExpectation = expectation(description: "Fetch image successful")
        
        viewModel.onImageFetched = { imageUrl in
            XCTAssertEqual(imageUrl, URL(string: "https://example.com/cat.jpg"))
            imageExpectation.fulfill()
        }
        
        viewModel.fetchCatContent()
        
        wait(for: [imageExpectation], timeout: 1.0)
    }
}
