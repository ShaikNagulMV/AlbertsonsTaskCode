//
//  MeaningsViewModelTests.swift
//  MeaningTests
//
//  Created by 1212199 on 25/11/21.
//

import XCTest
@testable import Meaning

class MeaningsViewModelTests: XCTestCase {

    func testGetMeaningsUpdate() {
        let viewModel = MeaningsViewModel()
        let expectation = self.expectation(
                  description: "Get the Meanings for the given acromine")
        viewModel.acromine.bind{
            if $0.caseInsensitiveCompare("AIDS") == .orderedSame {
                expectation.fulfill()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            viewModel.getMeanings("AIDS")
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
}
