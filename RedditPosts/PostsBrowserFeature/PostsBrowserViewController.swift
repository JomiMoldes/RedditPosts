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
import Extensions
import ModelsInterfaces

public class PostsBrowserViewController: UIViewController {
    
    private var viewModel: PostsBrowserViewModelProtocol
    private let customView = PostsBrowserView()
    
    var didSelectPost: ((PostProtocol) -> Void)?
    
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.viewModel.posts.count == 0 {
            self.customView.showLoader()
        }
    }
}

private extension PostsBrowserViewController {
    
    func bindViewModel() {
        let table = self.customView.tableView
        table.dataSource = self
        table.delegate = self
        table.rowHeight = PostViewCell.rowHeight
        table.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.identifier)
        
        self.viewModel.didError = { error in
            // TO DO: handle error
        }
        
        self.viewModel.didUpdate = { [weak self] in
            ensureMainThread {
                self?.customView.reloadData()
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
        var viewModel = self.viewModel.createViewCellModel(post: post)
        
        viewModel.didUpdateImage = {
            ensureMainThread {
                if let image = viewModel.thumbnail {
                    cell.showImage(image)
                    return
                }
                cell.showErrorImage()
            }
        }
        viewModel.didUpdateInfo = {
            ensureMainThread {
                cell.setup(viewModel)
            }
        }
        cell.setup(viewModel)
        return cell
    }
    
}

extension PostsBrowserViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let viewModels = self.viewModel.viewModels
        guard row < viewModels.count else {
            return
        }
        let viewModel = viewModels[row]
        viewModel.selected()
        
        let posts = self.viewModel.posts
        guard row < posts.count else {
            return
        }
        let post = posts[row]
        self.didSelectPost?(post)
    }
    
}
