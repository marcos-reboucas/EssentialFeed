//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 08/02/22.
//

import UIKit
import EssentialFeed

// The goal is to move the UIRefreshControl() creation, configuration and loading logic to another controller type (instead of having it on FeedViewController).

// private(set) - var can only be modified from inside the class FeedRefreshViewController

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view: UIRefreshControl =  {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onRefresh: (([FeedImage]) -> Void)?
    
    @objc func refresh() {
        view.beginRefreshing()
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onRefresh?(feed)
            }
            self?.view.endRefreshing()
        }
    }
}
