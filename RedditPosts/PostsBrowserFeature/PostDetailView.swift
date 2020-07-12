//
//  PostDetailView.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import Extensions

final class PostDetailView: UIView {
    
    let authorLabel: UILabel = createAuthorLabel()
    let titleLabel: UILabel = createTitleLabel()
    let imageView: UIImageView = createImageView()
    
    init() {
        super.init(frame: .zero)
        self.addSubviews()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PostDetailView {
    
    private func addSubviews() {
        self.addSubview(self.authorLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
    }
    
    private func addConstraints() {
        // TO DO: User a UIStackView instead
        self.authorLabel.addConstraintEqualToSuperView(anchors: [.right(-20.0), .left(20.0), .top(20.0)])
        self.authorLabel.addFixedConstraints([.height(20.0)])

        self.imageView.addFixedConstraints([.width(90.0), .height(90.0)])
        self.imageView.addConstraintEqualToSuperView(anchors: [.centerX(1.0)])
        self.imageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 10.0).isActive = true

        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10.0).isActive = true
        self.titleLabel.addConstraintEqualToSuperView(anchors: [.left(20.0), .right(-20.0)])
    }
    
}

private func createImageView() -> UIImageView {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
}

private func createAuthorLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 20.0)
    return label
}

private func createTitleLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = UIFont.systemFont(ofSize: 16.0)
    return label
}
