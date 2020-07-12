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
    let titleLabel = createTitleLabel()
    private let headerView = createHeaderView()
    
    private static let headerHeight: CGFloat = 40.0
    private var headerHeightConstraint: NSLayoutConstraint?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headerHeightConstraint?.constant = self.safeAreaInsets.top + PostsBrowserView.headerHeight
    }
}

private extension PostsBrowserView {
    
    func addSubviews() {
        self.addSubview(self.tableView)
        self.addSubview(self.headerView)
        self.addSubview(self.titleLabel)
    }
    
    func setConstraints() {
        self.tableView.addConstraintEqualToSuperView(anchors: [.right(0.0), .bottom(0.0)])
        self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5.0).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: PostsBrowserView.headerHeight).isActive = true
        
        self.headerView.addConstraintEqualToSuperView(anchors: [.width(1.0), .centerX(1.0), .top(0.0)])
        self.headerHeightConstraint = self.headerView.heightAnchor.constraint(equalToConstant: 0.0)
        self.headerHeightConstraint?.isActive = true
        
        self.titleLabel.addConstraintEqualToSuperView(anchors: [.width(1.0), .centerX(1.0)])
        self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -10.0).isActive = true
    }
    
    func setStyles() {
        self.tableView.backgroundColor = .clear
        self.backgroundColor = .black
        self.headerView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
    }
    
}

private func prepareTable() -> UITableView {
    let table = UITableView()
    table.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    return table
}

private func createHeaderView() -> UIView {
    let header = UIView()
    return header
}

private func createTitleLabel() -> UILabel {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
}
