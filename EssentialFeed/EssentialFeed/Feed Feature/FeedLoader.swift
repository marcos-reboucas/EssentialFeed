//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marcos Rebouças on 06/04/21.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    func load(completion: @escaping (Result) -> Void)
}
