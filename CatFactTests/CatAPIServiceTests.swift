//
//  CatAPIServiceTests.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


import XCTest
import Foundation
import Testing
@testable import CatFact

class CatAPIServiceTests: XCTestCase {
    
    var apiService: CatAPIService!
    var mockWebService: MockWebService!
    
    var viewModel: CatViewModel!
    var mockApiService: MockCatAPIService!
    
    override func setUp() {
        super.setUp()
        mockWebService = MockWebService()
        apiService = CatAPIService(webService: mockWebService)
        mockApiService = MockCatAPIService()
        viewModel = CatViewModel(apiService: mockApiService)
    }
    
    override func tearDown() {
        apiService = nil
        mockWebService = nil
        super.tearDown()
    }
    
    
    func testFetchCatFactSuccess() {
        mockWebService.result = .success(CatFact(data: ["Cats sleep for 70% of their lives."]))
        let expectation = self.expectation(description: "Fetch Cat Fact")
        
        viewModel.onFactFetched = { fact in
            XCTAssertEqual(fact, "Cats sleep for 70% of their lives.")
            expectation.fulfill()
        }
        
        viewModel.fetchCatContent()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCatImageSuccess() {
        mockWebService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch Cat Image Failure")
        
        apiService.fetchCatImage { result in
            switch result {
            case .success:
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Forced failure in mock service")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCatFactFailure() {
        mockWebService.result = .failure(NSError(domain: "Network error", code: -1, userInfo: nil))
        
        let expectation = self.expectation(description: "Fetch Cat Fact Failure")
        
        apiService.fetchCatFact { result in
            switch result {
            case .success:
                XCTFail("success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Invalid result type")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
