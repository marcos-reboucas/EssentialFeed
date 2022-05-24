//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 17/05/22.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
