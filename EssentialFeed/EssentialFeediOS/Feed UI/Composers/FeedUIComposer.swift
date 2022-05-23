//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 10/05/22.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(loadFeed: presenter.loadFeed)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = WeakRefVirtualProxy(refreshController)
        presenter.feedView = FeedViewAdapter(controller: feedController, imageLoader: imageLoader)
        return feedController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
            }
        }
    }
}

// Here we move memory management to Composer layer. Because the FeedPresenter shouldn't have to know or handle their dependencies lifetime.
// The virtual proxy will hold a weak reference to the object instance and pass the message forward, so when we set the loadingView (line 18) we weakfy it with the virtual proxy. To make it works we need to make WeakRefVirtualProxy conform to FeedLoadingView in the extension below.
private final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(viewModel)
    }
}

// OBS: Antes passavamos o FeedRefreshViewController direto para o FeedPresenter, dai tinha que tornar essa referencia weak em FeedPresenter. Como o FeedPresenter nao tem que gerenciar o ciclo de vida de suas dependencias, agora passamos WeakRefVirtualProxy com o FeedRefreshViewController dentro para o FeedPresenter. Assim agora quando FeedPresenter chama loadingView?.display(isLoading: true) ele esta chamando em WeakRefVirtualProxy, que chama em FeedRefreshViewController. Isso resolve o retain cycle que existia sem que o FeedPresenter tenha que se preocupar com isso.

private final class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.tableModel = viewModel.feed.map { model in
            FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init))
        }
    }
}
