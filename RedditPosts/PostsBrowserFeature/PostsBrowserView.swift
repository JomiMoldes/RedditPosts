//
//  PostsBrowserView.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import Extensions

final class PostsBrowserView: UIView {
    
    let tableView = prepareTable()
    
    init() {
        super.init(frame: .zero)
        self.addSubviews()
        self.setConstraints()
        self.setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.tableView.hideActivityIndicator()
        self.tableView.reloadData()
    }
    
    func showLoader() {
        self.tableView.showActivityIndicator()
    }
    
}

private extension PostsBrowserView {
    
    func addSubviews() {
        self.addSubview(self.tableView)
    }
    
    func setConstraints() {
        self.tableView.addConstraintEqualToSuperView(anchors: [.right(0.0), .top(0.0), .bottom(0.0)])
        self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5.0).isActive = true
    }
    
    func setStyles() {
        self.tableView.backgroundColor = .clear
        self.backgroundColor = .black
    }
    
}

private func prepareTable() -> UITableView {
    let table = UITableView()
    return table
}
