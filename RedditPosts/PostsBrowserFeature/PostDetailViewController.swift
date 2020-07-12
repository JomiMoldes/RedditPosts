//
//  PostDetailViewController.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 12/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import ModelsInterfaces
import PostsBrowserFeatureInterfaces
import Extensions

public class PostDetailViewController: UIViewController {
    
    private var viewModel: PostDetailViewModelProtocol
    private let customView = PostDetailView()
    
    public init(viewModel: PostDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = self.customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
}

private extension PostDetailViewController {
    
    func bindViewModel() {
        self.customView.authorLabel.text = self.viewModel.author
        self.customView.titleLabel.text = self.viewModel.title
        
        self.viewModel.didUpdateImage = { [weak self] image in
            ensureMainThread {
                self?.customView.imageView.image = image
            }
        }
    }
    
}
