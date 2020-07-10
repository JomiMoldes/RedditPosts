//
//  UIView+Extensions.swift
//  Utils
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public extension UIView {
    
    @discardableResult func addConstraintEqualToSuperView(anchors: [ViewAnchors]) -> [NSLayoutConstraint] {
        guard let superView = self.superview else {
            return [NSLayoutConstraint]()
        }
        
        return addConstraintEqualTo(anchors: anchors, view: superView)
    }
    
    @discardableResult func addConstraintEqualTo(anchors: [ViewAnchors], view: UIView) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        anchors.forEach { (anchor) in
            switch anchor {
            case .top(let value):
                constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: value))
            case .bottom(let value):
                constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: value))
            case .right(let value):
                constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: value))
            case .left(let value):
                constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: value))
            case .width(let value):
                constraints.append(self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: value))
            case .height(let value):
                constraints.append(self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: value))
            case .centerX(let value):
                constraints.append(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: value, constant: 0))
            case .centerY(let value, let constant):
                let anchorConstant: CGFloat = constant != nil ? constant! : 0
                constraints.append(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: value, constant: anchorConstant))
            }
        }
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func layoutToFillSuperview() {
        guard self.superview != nil else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraintEqualToSuperView(anchors: [.width(1.0), .centerX(1.0), .height(1.0), .centerY(1.0, 0.0)])
        
    }
    
    @discardableResult func addFixedConstraints(_ fixedConstraints: [ViewFixedConstraint]) -> [NSLayoutConstraint] {
        var heightConstraint: NSLayoutConstraint?
        var widthConstraint: NSLayoutConstraint?
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        fixedConstraints.forEach { (fixedConstraint) in
            switch fixedConstraint {
            case .height(let value):
                heightConstraint = self.heightAnchor.constraint(equalToConstant: value)
            case .width(let value):
                widthConstraint = self.widthAnchor.constraint(equalToConstant: value)
            }
            
        }
        
        let constraints = [heightConstraint, widthConstraint].compactMap { $0 }
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func roundTopCorners(radius: CGFloat = 15.0) {
        self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        layer.cornerRadius = radius
    }
}

public enum ViewAnchors {
    case top(CGFloat)
    case bottom(CGFloat)
    case left(CGFloat)
    case right(CGFloat)
    case width(CGFloat)
    case height(CGFloat)
    case centerX(CGFloat)
    case centerY(CGFloat, CGFloat?)
}

public enum ViewFixedConstraint {
    case height(CGFloat)
    case width(CGFloat)
}
