//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Marcos Reboucas on 10/06/22.
//

import XCTest
@testable import EssentialFeediOS

final class FeedPresenter {
    init(view: Any) {
        
    }
}

class FeedPresenterTests: XCTestCase {
    
    // We recomend to start from the degenerate, simple and trivial behaviors first. In this case, simply making sure the FeedPresenter doesn't perform any work in the constructor (the init method doesn't have any behavior, that's what we want: "no behaviors in initializers").
    func test_init_doesNotSendMessagesToView() {
        let view = ViewSpy()
        
        _ = FeedPresenter(view: view)
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
}

// MARK: - Helpers

// We create a view instance and for this case we need a Spy so we can investigate which messages the view received.

private class ViewSpy {
    let messages = [Any]()
}
