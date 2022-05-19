//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 08/02/22.
//

import UIKit

// The goal is to move the UIRefreshControl() creation, configuration and loading logic to another controller type (FeedRefreshViewController), instead of having it on FeedViewController.

// private(set) - var can only be modified from inside the class FeedRefreshViewController

final class FeedRefreshViewController: NSObject, FeedLoadingView {
    private(set) lazy var view = loadView()
    
    private let presenter: FeedPresenter
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
    @objc func refresh() {
        presenter.loadFeed()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
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
