//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Marcos Reboucas on 31/05/22.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
