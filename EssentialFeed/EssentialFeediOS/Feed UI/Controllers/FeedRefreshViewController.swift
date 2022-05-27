//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 08/02/22.
//

import UIKit

// The goal is to move the UIRefreshControl() creation, configuration and loading logic to another controller type (FeedRefreshViewController), instead of having it on FeedViewController.

// private(set) - var can only be modified from inside the class FeedRefreshViewController

// Esta class FeedRefreshViewController (e o delegate FeedRefreshViewControllerDelegate) não está mais sendo usada no app, fizemos o merge dela com FeedViewController quando refatoramos para usar Storyboard: Merge FeedRefreshViewController with FeedViewController since the `UIRefreshControl` creation and configuration now lives in the Storyboard

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {
    @IBOutlet private var view: UIRefreshControl?
    
    var delegate: FeedRefreshViewControllerDelegate?
    
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
}
