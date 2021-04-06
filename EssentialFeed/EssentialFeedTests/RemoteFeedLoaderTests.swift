//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Marcos Rebouças on 06/04/21.
//

import XCTest

class RemoteFeedLoader {}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
