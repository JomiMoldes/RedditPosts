//
//  PostsSplitViewController.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit

public class PostsSplitViewController: UIViewController {
    
    private let listContainer: UIView = UIView()
    private let detailContainer: UIView = UIView()
    
    private var splitConstraints = [NSLayoutConstraint]()
    private var narrowConstraints = [NSLayoutConstraint]()
    
    public init() {
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
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.addConstraints()
    }
    
}

private extension PostsSplitViewController {
    
    private func addSubviews() {
        self.view.addSubview(self.listContainer)
        self.view.addSubview(self.detailContainer)
    }
    
    private func addDetailsConstraints() {
        self.detailContainer.addConstraintEqualToSuperView(anchors: [.right(0.0), .height(1.0), .centerY(1.0)])
        self.detailContainer.leftAnchor.constraint(equalTo: self.listContainer.rightAnchor, constant: 0.0).isActive = true
    }
    
    private func addConstraints() {
        if shouldSplit() {
            self.splitView()
        } else {
            self.narrowView()
        }
    }
    
    private func shouldSplit() -> Bool {
        return traitCollection.horizontalSizeClass == .regular &&
            traitCollection.verticalSizeClass == .regular ||
            traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .compact
    }
    
    
    private func splitView() {
        NSLayoutConstraint.deactivate(narrowConstraints)
        let listConstraints = self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .centerY(1.0), .left(0.0)])
        let preferedWitdhConstraint = self.listContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        preferedWitdhConstraint.priority = .defaultLow
        let maxWitdhConstraint = self.listContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 350.0)
        maxWitdhConstraint.priority = .defaultHigh
        splitConstraints.append(contentsOf: listConstraints)
        splitConstraints.append(preferedWitdhConstraint)
        splitConstraints.append(maxWitdhConstraint)
        NSLayoutConstraint.activate(splitConstraints)
    }
    
    private func narrowView() {
        NSLayoutConstraint.deactivate(splitConstraints)
        narrowConstraints.append(contentsOf: self.listContainer.addConstraintEqualToSuperView(anchors: [.height(1.0), .width(1.0), .centerY(1.0), .centerX(1.0)]))
        NSLayoutConstraint.activate(narrowConstraints)
    }
}
