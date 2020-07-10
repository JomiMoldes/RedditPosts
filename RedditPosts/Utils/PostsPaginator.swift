//
//  PostPagination.swift
//  Utils
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UtilsInterfaces
import ModelsInterfaces
import ServicesInterfaces

public class PostsPaginator: PaginationProtocol {
    
    public var results: [PostProtocol]
    public var before: String?
    public var after: String?
    
    private let service: PostServiceProtocol
    private let postsCreator: PostsListCreatorProtocol
    
    public init(results: [PostProtocol] = [PostProtocol](),
                before: String? = nil,
                after: String? = nil,
                service: PostServiceProtocol,
                postsCreator: PostsListCreatorProtocol) {
        self.results = results
        self.before = before
        self.after = after
        self.service = service
        self.postsCreator = postsCreator
    }
    
    enum CodingKeys: String, CodingKey {
        case results, before, after
    }
    
    public func fetchLatest(callback: @escaping (Result<Void, NetworkError>) -> Void) {
        self.service.fetch(after: self.after ?? "1") { result in
            switch result {
            case .success(let posts):
                print(posts)
                // TO DO: make list Codable
                var results = [PostProtocol?]()
                posts.forEach {
                    if let post = self.postsCreator.createPost(from: $0) {
                        results.append(post)
                    }
                }
                self.results = results.compactMap{ $0 }
                callback(.success(()))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func fetchOlder(result: @escaping (Result<Void, NetworkError>) -> Void) {
        
    }
    
}

extension PostsPaginator {
    public static func == (lhs: PostsPaginator, rhs: PostsPaginator) -> Bool {
        return lhs.before == rhs.before &&
            lhs.after == rhs.after
    }
}
