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
import PostsBrowserFeatureInterfaces
//import Extensions

public class PostsSplitViewController: UIViewController {
    
    private let listContainer: UIView = UIView()
    private let detailContainer: UIView = UIView()
    
    private var splitConstraints = [NSLayoutConstraint]()
    private var narrowConstraints = [NSLayoutConstraint]()
    
    
    private var viewModel: PostsSplitViewModelProtocol
    private var listLeftConstraint: NSLayoutConstraint?
    
    public init(viewModel: PostsSplitViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.addSubviews()
        self.addConstraints()
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
        if self.splitConstraints.count > 0 {
            NSLayoutConstraint.activate(self.splitConstraints)
            return
        }
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
        if self.narrowConstraints.count > 0 {
            NSLayoutConstraint.activate(self.narrowConstraints)
            return
        }
        let listConstraints = self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .width(1.0), .centerY(1.0), .centerX(1.0)])
        self.listLeftConstraint = listConstraints[3]
        narrowConstraints.append(contentsOf: listConstraints)
        narrowConstraints.append(contentsOf: self.detailContainer.addConstraintEqualToSuperView(anchors: [.width(1.0), .centerX(1.0)]))
        narrowConstraints.append(self.detailContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor))
        narrowConstraints.append(self.detailContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        NSLayoutConstraint.activate(narrowConstraints)
    }
    
    func addListViewController() {
        let viewModel = self.viewModel.createBrowserViewModel(shouldSplit: self.shouldSplit())
        let controller = PostsBrowserViewController(viewModel: viewModel,
                                                    shouldAutoSelect: { [weak self] in
                                                        return self?.shouldSplit() ?? false
        })
        self.load(viewController: controller, intoView: self.listContainer)
        
        controller.didSelectPost = { [weak self] post in
            ensureMainThread {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addDetailViewController(post: post)
                if strongSelf.shouldSplit() == false {
                    DispatchQueue.main.async {
                        strongSelf.animateListOut()
                    }
                }
            }
        }
    }
    
    func addDetailViewController(post: PostProtocol) {
        self.detailContainer.subviews.forEach { $0.removeFromSuperview() }
        let viewModel = self.viewModel.createDetailViewModel(post: post)
        let controller = PostDetailViewController(viewModel: viewModel)
        self.load(viewController: controller, intoView: self.detailContainer)
        viewModel.loadThumbnail()
        self.addGesturesToDetails()
    }
    
}

private extension PostsSplitViewController {
    
    // TO DO: This is not the way I should handle this feature
    func addGesturesToDetails() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTouchDetail))
        self.detailContainer.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDetail))
        self.detailContainer.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didTouchDetail(_: UITapGestureRecognizer) {
        if self.shouldSplit() == false {
            self.animateListIn()
        }
    }
    
    @objc func didSwipeDetail(gesture: UITapGestureRecognizer) {
        if self.shouldSplit() == false {
            self.animateListIn()
        }
    }
    
    func animateListOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.listLeftConstraint?.constant = -self.listContainer.frame.width
            self.view.layoutIfNeeded()
        })
    }
    
    func animateListIn() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.listLeftConstraint?.constant = 0.0
            self.view.layoutIfNeeded()
        })
    }
    
}
