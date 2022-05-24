//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 08/02/22.
//

import UIKit

// The goal is to move the UIRefreshControl() creation, configuration and loading logic to another controller type (FeedRefreshViewController), instead of having it on FeedViewController.

// private(set) - var can only be modified from inside the class FeedRefreshViewController

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {
    private(set) lazy var view = loadView()
    
    private let delegate: FeedRefreshViewControllerDelegate
    
    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
    }
    
    @objc func refresh() {
        delegate.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
