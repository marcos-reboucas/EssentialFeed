//
//  MainQueueDispatchDecorator.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 09/06/22.
//

import Foundation
import EssentialFeed

// The Decorator pattern is used to add behavior to an instance while keeping the same interface. In this example we want FeedLoader instance to be dispatched in the main thread (this is the added behavior). MainQueueDispatchDecorator also need to conform to FeedLoader because it's going to behave as a FeedLoader, forwarding the messages to the 'decoratee'. The decorator add behavior to the instance without changing the instance, that's the SOLID Open Closed Principle (we're adding behavior without changing code). Here we 'decorate' all the instances of FeedLoader in a single place (we have just one screen and one instance of FeedLoader in our app but image if we had 50 screens, this thread checking would be spread all over the code). Obs: This is not being used anymore as we implemented the Generic version MainQueueDispatchDecorator<T>, moving the conformance to an extension.

private final class MainQueueDispatchDecorator_FeedLoader: FeedLoader {
    
    private let decoratee: FeedLoader
    
    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { result in
            if Thread.isMainThread {
                completion(result)
            } else {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}

final class MainQueueDispatchDecorator<T> {
    
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: FeedImageDataLoader where T == FeedImageDataLoader {
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
