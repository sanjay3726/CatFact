//
//  WebServiceManager.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


import XCTest
@testable import CatFact
import Foundation

class WebServiceManagerTests: XCTestCase {
    
    var webService: WebServiceManager!
    
    override func setUp() {
        super.setUp()
        webService = WebServiceManager()
    }
    
    override func tearDown() {
        webService = nil
        super.tearDown()
    }
    
    func testFetchCatFact() {
        // Given
        let url = URL(string: "https://meowfacts.herokuapp.com/")!
        
        // When
        let expectation = self.expectation(description: "Fetch Cat Fact")
        
        webService.fetch(from: url) { (result: Result<CatFact, Error>) in
            switch result {
            case .success(let catFact):
                XCTAssertNotNil(catFact.data)
                XCTAssertFalse(catFact.data.isEmpty)
            case .failure(let error):
                XCTFail("Expected success but got error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCatImage() {
        // Given
        let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
        
        // When
        let expectation = self.expectation(description: "Fetch Cat Image")
        
        webService.fetch(from: url) { (result: Result<[CatImage], Error>) in
            switch result {
            case .success(let images):
                XCTAssertEqual(images.count, 1)
                XCTAssertNotNil(images.first?.url)
                XCTAssertFalse(images.first!.url.isEmpty)
            case .failure(let error):
                XCTFail("Expected success but got error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
