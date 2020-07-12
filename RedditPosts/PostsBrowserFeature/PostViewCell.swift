//
//  PostViewCell.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import PostsBrowserFeatureInterfaces

final class PostViewCell: UITableViewCell {
    
    static let identifier: String = "PostViewCell"
    static let rowHeight: CGFloat = 200.0
    
    let verticalStack: UIStackView = createVerticalStack()
    let topStackView: UIStackView = createTopStackView()
    let middleStackView: UIStackView = createMiddleStackView()
    let bottomStackView: UIStackView = createBottomStackView()
    
    let authorLabel: UILabel = createAuthorLabel()
    let timeLabel: UILabel = createTimeLabel()
    let readView: UIView = createCircle()
    
    let thumbnailView: UIImageView = createImageView()
    let infoLabel: UILabel = createInfoLabel()
    let disclosureButton: UIButton = createDisclosureButton()
    
    let dismissButton: UIButton = createDismissButton()
    let commentsLabel: UILabel = createCommentsLabel()
    
    private var task: URLSessionDataTask?
    
    var didTapDismiss: (() -> Void)?
    
    private static let circleRadius: CGFloat = 5.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        setStyles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: PostViewCellViewModelProtocol) {
        self.authorLabel.text = viewModel.author
        self.timeLabel.text = viewModel.timePassed
        self.infoLabel.text = viewModel.title
        
        self.commentsLabel.text = viewModel.comments
        self.dismissButton.setAttributedTitle(viewModel.dismissTitle, for: .normal)
        
        self.showDefaultImage()
        self.task?.cancel()
        self.task = viewModel.loadThumbnail()
        
        if viewModel.read {
            self.readView.removeFromSuperview()
        } else {
            self.topStackView.insertArrangedSubview(self.readView, at: 0)
        }
        
        self.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    func showImage(_ image: UIImage) {
        self.thumbnailView.hideActivityIndicator()
        self.thumbnailView.image = image
    }
    
    func showErrorImage() {
        self.thumbnailView.hideActivityIndicator()
        self.thumbnailView.image = UIImage(color: .gray, size: CGSize(width: 10.0, height: 10.0))
    }
    
    @objc func dismissButtonTapped() {
        self.didTapDismiss?()
    }
    
}

private extension PostViewCell {
    
    func addSubviews() {
        self.contentView.addSubview(self.verticalStack)
        self.verticalStack.addArrangedSubview(self.topStackView)
        self.verticalStack.addArrangedSubview(self.middleStackView)
        self.verticalStack.addArrangedSubview(self.bottomStackView)
        
        self.topStackView.addArrangedSubview(self.readView)
        self.topStackView.addArrangedSubview(self.authorLabel)
        self.topStackView.addArrangedSubview(self.timeLabel)
        
        self.middleStackView.addArrangedSubview(self.thumbnailView)
        self.middleStackView.addArrangedSubview(self.infoLabel)
        self.middleStackView.addArrangedSubview(self.disclosureButton)
        
        self.bottomStackView.addArrangedSubview(self.dismissButton)
        self.bottomStackView.addArrangedSubview(self.commentsLabel)
    }
    
    func setConstraints() {
        self.verticalStack.layoutToFillSuperview()
        self.thumbnailView.addFixedConstraints([.width(90.0), .height(90.0)])
        let readSize = PostViewCell.circleRadius * 2
        self.readView.addFixedConstraints([.width(readSize),
                                           .height(readSize)])
    }
    
    func setStyles() {
        self.contentView.backgroundColor = .black
        self.authorLabel.textColor = .gray
        self.timeLabel.textColor = .gray
        self.infoLabel.textColor = .gray
        self.commentsLabel.textColor = .orange
        
        self.dismissButton.setTitleColor(.white, for: .normal)
        
        self.authorLabel.font = UIFont.systemFont(ofSize: 18.0)
        self.timeLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.infoLabel.font = UIFont.systemFont(ofSize: 13.0)
        self.commentsLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.readView.backgroundColor = .orange

        self.readView.layer.cornerRadius = PostViewCell.circleRadius
        
        self.backgroundColor = .clear
    }
    
    func showDefaultImage() {
        guard let image = UIImage(color: .blue, size: CGSize(width: 30.0, height: 30.0)) else {
            return
        }
        self.thumbnailView.image = image
        self.thumbnailView.frame = CGRect(origin: self.thumbnailView.frame.origin, size: image.size)
        self.thumbnailView.showActivityIndicator()
    }
    
}

private func createAuthorLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    label.numberOfLines = 1
    return label
}

private func createTimeLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.numberOfLines = 1
    return label
}

private func createTopStackView() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.spacing = 10.0
    stack.alignment = .center
    return stack
}

private func createMiddleStackView() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.spacing = 10.0
    stack.alignment = .center
    return stack
}

private func createBottomStackView() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fillProportionally
    stack.spacing = 10.0
    stack.alignment = .center
    return stack
}

private func createVerticalStack() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .equalCentering
    stack.spacing = 10.0
    return stack
}

private func createImageView() -> UIImageView {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return view
}

private func createInfoLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    label.numberOfLines = 0
    return label
}

private func createDisclosureButton() -> UIButton {
    let button = UIButton()
    // TO DO: Replace by a nicer asset
    button.setTitle(">", for: .normal)
    button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return button
}

private func createDismissButton() -> UIButton {
    let button = UIButton()
    return button
}

private func createCommentsLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .left
    return label
}

private func createCircle() -> UIView {
    let view = UIView()
    view.layer.masksToBounds = true
    return view
}
