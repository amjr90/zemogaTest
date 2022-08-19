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
        print("get cache posts")
        cacheService.getPosts { result in
            switch result{
            case .success(let posts):
                if posts.isEmpty{
                    self.fetchPosts()
                }
                else{
                    let favoritePosts = posts.filter({$0.favorite == true})
                    let notFavoirtePost = posts.filter({$0.favorite != true})
                    if !favoritePosts.isEmpty && notFavoirtePost.isEmpty{
                        self.presenter?.presentPosts(posts: posts)
                        self.fetchPosts()
                    }
                    else{
                        self.presenter?.presentPosts(posts: posts)
                    }
                }
            case .failure(_):
                self.fetchPosts()
            }
        }
    }
    
    func fetchPosts() {
        print("get posts from internet")
        service.getPosts { result in
            switch result{
            case .success(let posts):
                self.cacheService.savePosts(posts: posts)
                self.presenter?.presentPosts(posts: posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
