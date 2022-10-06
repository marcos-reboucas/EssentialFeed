//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Marcos Reboucas on 06/10/22.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data("any data".utf8)
}
