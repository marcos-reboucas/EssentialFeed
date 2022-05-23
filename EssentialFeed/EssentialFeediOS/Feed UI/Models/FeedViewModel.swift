//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 12/05/22.
//

// Esta classe FeedViewModel não está sendo usada mais na última implementação em MVP com o FeedPresenter, deixei aqui apenas pelo exemplo de Observer genérico com closure que notifica e passa valores para outros objetos.

import Foundation
import EssentialFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    // A closure observer for each state that may change...
    var onLoadingChangeState: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?
    
    func loadFeed() {
        // ...that pass state transitions directly in the closure
        onLoadingChangeState?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingChangeState?(false)
        }
    }
}
