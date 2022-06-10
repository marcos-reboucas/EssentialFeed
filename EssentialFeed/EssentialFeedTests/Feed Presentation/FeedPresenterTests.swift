//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Marcos Reboucas on 10/06/22.
//

import XCTest
import EssentialFeed
//@testable import EssentialFeediOS

final class FeedPresenter {
    init(view: Any) {
        
    }
}

class FeedPresenterTests: XCTestCase {
    
    // We recomend to start from the degenerate, simple and trivial behaviors first. In this case, simply making sure the FeedPresenter doesn't perform any work in the constructor (the init method doesn't have any behavior, that's what we want: "no behaviors in initializers").
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    // MARK: - Helpers

    // Factory Method
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(view: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }

    // We create a view instance and for this case we need a Spy so we can investigate which messages the view received.
    private class ViewSpy {
        let messages = [Any]()
    }
}
