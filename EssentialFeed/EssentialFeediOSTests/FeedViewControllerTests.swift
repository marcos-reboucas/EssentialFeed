//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Marcos Reboucas on 23/11/21.
//

import XCTest

final class FeedViewController {
    init(loader: FeedViewControllerTests.LoaderSpy) {
        
    }
}

final class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    // MARK: - Helpers

    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }

}

