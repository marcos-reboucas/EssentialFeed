//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Marcos Reboucas on 02/08/22.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
