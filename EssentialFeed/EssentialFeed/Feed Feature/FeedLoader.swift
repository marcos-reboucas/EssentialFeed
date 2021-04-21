//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marcos Rebouças on 06/04/21.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
