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
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.addConstraints()
    }
    
}

private extension PostsSplitViewController {
    
    func addSubviews() {
        self.view.addSubview(self.listContainer)
        self.view.addSubview(self.detailContainer)
    }
    
    func addDetailsConstraints() {
        self.detailContainer.addConstraintEqualToSuperView(anchors: [.right(0.0), .height(1.0), .centerY(1.0)])
        self.detailContainer.leftAnchor.constraint(equalTo: self.listContainer.rightAnchor, constant: 0.0).isActive = true
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
        let listConstraints = self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .centerY(1.0)])
        let leftConstraint = self.listContainer.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
        let preferedWitdhConstraint = self.listContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        preferedWitdhConstraint.priority = .defaultLow
        let maxWitdhConstraint = self.listContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 350.0)
        maxWitdhConstraint.priority = .defaultHigh
        splitConstraints.append(contentsOf: listConstraints)
        splitConstraints.append(leftConstraint)
        splitConstraints.append(preferedWitdhConstraint)
        splitConstraints.append(maxWitdhConstraint)
        NSLayoutConstraint.activate(splitConstraints)
    }
    
    func narrowView() {
        NSLayoutConstraint.deactivate(splitConstraints)
        narrowConstraints.append(contentsOf: self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .width(1.0), .centerY(1.0), .centerX(1.0)]))
        NSLayoutConstraint.activate(narrowConstraints)
    }
    
    func addListViewController() {
        let viewModel = PostsBrowserViewModel(paginator: paginator, imageProvider: self.imageProvider)
        let controller = PostsBrowserViewController(viewModel: viewModel)
        self.load(viewController: controller, intoView: self.listContainer)
        
        controller.didSelectPost = { post in
            print(post.author)
        }
    }
}
