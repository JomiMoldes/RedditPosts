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
            case .centerY(let value):
                let anchorConstant: CGFloat = 0
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
        
        self.addConstraintEqualToSuperView(anchors: [.width(1.0), .centerX(1.0), .height(1.0), .centerY(1.0)])
        
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
    case centerY(CGFloat)
}

public enum ViewFixedConstraint {
    case height(CGFloat)
    case width(CGFloat)
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

public extension UIView {
    
    func showActivityIndicator(withBlurEffect blurEffectEnabled: Bool? = false, color: UIColor = .white, style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large) {
        
        if blurEffectEnabled! {
            let visualEffectView = UIVisualEffectView()
            if #available(iOS 13.0, *) {
                visualEffectView.effect = self.traitCollection.userInterfaceStyle == .dark ? UIBlurEffect(style: .dark) : UIBlurEffect(style: .light)
            } else {
                visualEffectView.effect = UIBlurEffect(style: .light)
            }
            visualEffectView.frame = self.bounds
            self.addSubview(visualEffectView)
        }
        
        let loader = UIActivityIndicatorView(style: style)
        if #available(iOS 13.0, *) {
            loader.color = self.traitCollection.userInterfaceStyle == .dark ? .gray : color
        } else {
            loader.color = color
        }
        loader.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.addSubview(loader)
        loader.startAnimating()
        
    }
    
    func hideActivityIndicator() {
        
        self.subviews.forEach {
            if let view = $0 as? UIActivityIndicatorView {
                view.stopAnimating()
                view.removeFromSuperview()
            }
            if let view = $0 as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
        
    }
}
public extension UIViewController {
    
    func load(viewController: UIViewController, intoView: UIView? = .none, insets: UIEdgeInsets = .zero) {
        let containerView: UIView = intoView ?? view
        self.addChild(viewController)
        viewController.view.loadInto(containerView: containerView, insets: insets)
        viewController.didMove(toParent: self)
    }

    func remove(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }

}

public extension UIView {
    
    func loadInto(containerView: UIView, insets: UIEdgeInsets = .zero) {
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: insets.bottom),
            leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: insets.left)
        ])
    }
}
