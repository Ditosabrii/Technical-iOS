//
//  Tehnical_TestiOSTests.swift
//  Tehnical-TestiOSTests
//
//  Created by Dito on 17/10/23.
//

import XCTest
@testable import Tehnical_TestiOS

final class Tehnical_TestiOSTests: XCTestCase {
    
    let apiManager = MealAPIManager.shared
    
    override func setUpWithError() throws {
 
    }

    override func tearDownWithError() throws {
     
    }
    
    func testAPISearchMeals() {
        let expectation = XCTestExpectation(description: "Mengambil data makanan dari API")
        
        apiManager.searchMeals(query: "pasta") { (meals, error) in
            XCTAssertNotNil(meals, "Gagal mengambil data makanan")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
  
    
}
