//
//  PostsSplitViewController.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import ModelsInterfaces
import UtilsInterfaces
import Extensions

public class PostsSplitViewController: UIViewController {
    
    private let listContainer: UIView = UIView()
    private let detailContainer: UIView = UIView()
    
    private var splitConstraints = [NSLayoutConstraint]()
    private var narrowConstraints = [NSLayoutConstraint]()
    
    private let paginator: PostsPaginatorProtocol
    private let imageProvider: ImageProviderProtocol
    
    public init(paginator: PostsPaginatorProtocol,
                imageProvider: ImageProviderProtocol) {
        self.paginator = paginator
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
        self.addSubviews()
        self.addConstraints()
        self.addDetailsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addListViewController()
        self.view.backgroundColor = .white
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.addConstraints()
    }
    
}

private extension PostsSplitViewController {
    
    func addSubviews() {
        self.view.addSubview(self.detailContainer)
        self.view.addSubview(self.listContainer)
    }
    
    func addDetailsConstraints() {
        
    }
    
    func addConstraints() {
        if shouldSplit() {
            self.splitView()
        } else {
            self.narrowView()
        }
    }
    
    func shouldSplit() -> Bool {
        return traitCollection.horizontalSizeClass == .regular &&
            traitCollection.verticalSizeClass == .regular ||
            traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .compact
    }
    
    
    func splitView() {
        NSLayoutConstraint.deactivate(narrowConstraints)
        let listConstraints = self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .centerY(1.0), .left(0.0)])
        let preferedWitdhConstraint = self.listContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        preferedWitdhConstraint.priority = .defaultHigh
        let maxWitdhConstraint = self.listContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 350.0)
        maxWitdhConstraint.priority = .required
        splitConstraints.append(contentsOf: listConstraints)
        splitConstraints.append(preferedWitdhConstraint)
        splitConstraints.append(maxWitdhConstraint)
        
        
        let detailConstraints = self.detailContainer.addConstraintEqualToSuperView(anchors: [ .height(1.0), .centerY(1.0)])
        let detailLeftConstraint = self.detailContainer.leadingAnchor.constraint(equalTo: self.listContainer.trailingAnchor)
        detailLeftConstraint.priority = .defaultHigh
        let detailLeftConstraintRequired = self.detailContainer.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor, constant: 350)
        detailLeftConstraintRequired.priority = .required
        let rightConstraint = self.detailContainer.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10.0)
        
        splitConstraints.append(contentsOf: detailConstraints)
        splitConstraints.append(detailLeftConstraint)
        splitConstraints.append(detailLeftConstraintRequired)
        splitConstraints.append(rightConstraint)
        
        NSLayoutConstraint.activate(splitConstraints)
    }
    
    func narrowView() {
        NSLayoutConstraint.deactivate(splitConstraints)
        narrowConstraints.append(contentsOf: self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .width(1.0), .centerY(1.0), .centerX(1.0)]))
        narrowConstraints.append(contentsOf: self.detailContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .width(1.0), .centerY(1.0), .centerX(1.0)]))
        NSLayoutConstraint.activate(narrowConstraints)
    }
    
    func addListViewController() {
        let viewModel = PostsBrowserViewModel(paginator: paginator, imageProvider: self.imageProvider)
        let controller = PostsBrowserViewController(viewModel: viewModel)
        self.load(viewController: controller, intoView: self.listContainer)
        
        controller.didSelectPost = { post in
            ensureMainThread {
                self.addDetailViewController(post: post)
            }
        }
    }
    
    func addDetailViewController(post: PostProtocol) {
        self.detailContainer.subviews.forEach { $0.removeFromSuperview() }
        let viewModel = PostDetailViewModel(post: post,
                                            imageProvider: self.imageProvider)
        let controller = PostDetailViewController(viewModel: viewModel)
        self.load(viewController: controller, intoView: self.detailContainer)
        viewModel.loadThumbnail()
    }
}
