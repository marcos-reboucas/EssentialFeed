//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 21/12/21.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    @IBOutlet private(set) public var locationContainer: UIView!
    @IBOutlet private(set) public var locationLabel: UILabel!
    @IBOutlet private(set) public var descriptionLabel: UILabel!
    @IBOutlet private(set) public var feedImageContainer: UIView!
    @IBOutlet private(set) public var feedImageView: UIImageView!
    @IBOutlet private(set) public var feedImageRetryButton: UIButton!
    
    
    // Debuga adicionando breakpoints no teste que está failing quando coloca o botão como Outlet.
    
//    private(set) public lazy var feedImageRetryButton: UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
//        return button
//    }()
    
    var onRetry: (() -> Void)?
    
    @IBAction private func retryButtonTapped() {
        onRetry?()
    }
}
