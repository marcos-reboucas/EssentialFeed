//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Marcos Reboucas on 16/06/21.
//

import Foundation
import EssentialFeed

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
