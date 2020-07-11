//
//  ViewController.swift
//  RedditPosts
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import UIKit
import PostsBrowserFeature
import ServicesInterfaces
import ModelsInterfaces
import Services
import UtilsInterfaces
import Utils
import Models

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
//        let service: PostServiceProtocol = PostsService(deviceId: UIDevice.current.identifierForVendor!.uuidString)
//        let decodable = DecodableHelper()
//        let postsCreator: PostsListCreatorProtocol = PostsListCreator(decodableHelper: decodable)
//        let paginator: PostsPaginatorProtocol = PostsPaginator(service: service,
//                                                               postsCreator: postsCreator)
//        let viewModel = PostsBrowserViewModel(paginator: paginator)
//        let controller = PostsBrowserViewController(viewModel: viewModel)
        let controller = PostsSplitViewController()

        self.navigationController?.pushViewController(controller, animated: false)
    }

}
