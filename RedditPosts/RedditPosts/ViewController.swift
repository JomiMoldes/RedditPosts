//
//  ViewController.swift
//  RedditPosts
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import UIKit
import PostsBrowserFeature
import PostsBrowserFeatureInterfaces
import Services
import Utils
import Models

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let service: PostServiceProtocol = PostsService(deviceId: UIDevice.current.identifierForVendor!.uuidString)
        let decodable = DecodableHelper()
        let postsCreator: PostsListCreatorProtocol = PostsListCreator(decodableHelper: decodable)
        let paginator: PostsPaginatorProtocol = PostsPaginator(service: service,
                                                               postsCreator: postsCreator)
        let imageProvider = ImageProvider()
        let dateUtils = DateUtils()
        let viewModel: PostsSplitViewModelProtocol = PostsSplitViewModel(dateUtils: dateUtils,
                                                                         paginator: paginator,
                                                                         imageProvider: imageProvider)
        let controller = PostsSplitViewController(viewModel: viewModel)

        self.navigationController?.pushViewController(controller, animated: false)
    }

}
