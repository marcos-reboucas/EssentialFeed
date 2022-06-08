//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 19/05/22.
//

import Foundation
import EssentialFeed

// Criamos essas 2 structs com view models (FeedLoadingViewModel e FeedViewModel) substituindo os types Bool e [FeedImage] que eram passados diretamente antes. Fizemos isso para clarificar a comunicação entre a presentation layer e a UI layer. As view models são 'pure data'. Em MVP as view models, também chamadas de ViewData ou PresentationModel, carregam apenas Data para a view que está sendo apresentada, e não possuem behavior. Isso difere do MVVM onde as view models tem dependencias e behavior. OBS: Mudamos essas 2 view models para seus proprios arquivos em 'Feed Presentation'.

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
    var feedView: FeedView
    var loadingView: FeedLoadingView
    
    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
             tableName: "Feed",
             bundle: Bundle(for: FeedPresenter.self),
             comment: "Title for the feed view")
    }
    
    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
