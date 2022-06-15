//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 15/06/22.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
