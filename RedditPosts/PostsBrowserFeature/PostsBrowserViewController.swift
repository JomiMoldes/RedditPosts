//
//  PostsBrowserViewController.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit
import PostsBrowserFeatureInterfaces

public class PostsBrowserViewController: UIViewController {
    
    private var viewModel: PostsBrowserViewModelProtocol
    private let customView = PostsBrowserView()
    
    public init(viewModel: PostsBrowserViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        self.view = self.customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchPosts()
        self.bindViewModel()
    }
}

private extension PostsBrowserViewController {
    
    func bindViewModel() {
        let table = self.customView.tableView
        table.dataSource = self
        table.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.identifier)
        
        self.viewModel.didError = { error in
            // TO DO: handle error
        }
        
        self.viewModel.didUpdate = { [weak self] in
            ensureMainThread {
                self?.customView.tableView.reloadData()
            }
        }
    }
    
}

extension PostsBrowserViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as? PostViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let posts = self.viewModel.posts
        guard row < posts.count else {
            return cell
        }
        let post = posts[row]
        let viewModel = PostViewCellViewModel(post: post)
        cell.setup(viewModel)
        return cell
    }
    
}

// TO DO: Share this
func ensureMainThread(_ completion: @escaping () -> Void) {
    if Thread.isMainThread {
        completion()
        return
    }
    DispatchQueue.main.async {
        completion()
    }
}
