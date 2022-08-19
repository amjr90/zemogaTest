//
//  PostsInteractor.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 17/08/22.
//
//  This template was created by AMJR
//

import Foundation
import Infrastructure

class PostsInteractor: PostsInteractorProtocol {
    
    
    weak var presenter: PostsPresenterProtocol?
    let cacheService = PostRepositoryCoreData()
    let service = PostsRepositoryURLSession()
    
    func getCachedPosts() {
        cacheService.getPosts { result in
            switch result{
            case .success(let posts):
                if posts.count > 0{
                    self.presenter?.presentPosts(posts: posts)
                }
                else{
                    self.fetchPosts()
                }
            case .failure(_):
                self.fetchPosts()
            }
        }
    }
    
    func fetchPosts() {
        service.getPosts { result in
            switch result{
            case .success(let posts):
                self.cacheService.savePosts(posts: posts, result: true)
                self.presenter?.presentPosts(posts: posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
