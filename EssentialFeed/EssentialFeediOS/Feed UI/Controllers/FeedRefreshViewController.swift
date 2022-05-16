//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 08/02/22.
//

import UIKit

// The goal is to move the UIRefreshControl() creation, configuration and loading logic to another controller type (FeedRefreshViewController), instead of having it on FeedViewController.

// private(set) - var can only be modified from inside the class FeedRefreshViewController

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view = binded(UIRefreshControl())
    
    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func refresh() {
        viewModel.loadFeed()
    }
    
    func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        // just set the o onLoadingChangeState observer:
        viewModel.onLoadingChangeState = { [weak view] isLoading in
            if isLoading {
                view?.beginRefreshing()
            } else {
                view?.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
