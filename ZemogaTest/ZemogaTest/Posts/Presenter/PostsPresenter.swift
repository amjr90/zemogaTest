//
//  PostsPresenter.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 17/08/22.
//
//  This template was created by AMJR
//

import Foundation
import Domain
import Infrastructure

class PostsPresenter: PostsPresenterProtocol {
    var router: PostsRouterProtocol?
    var interactor: PostsInteractorProtocol?
    weak var view: PostsViewProtocol?
    
    var posts: [Post] = []
    let cacheService = PostRepositoryCoreData()
    
    func notifyViewLoaded(){
        view?.setTitle()
        view?.setupView()
        view?.setupTableView()
        view?.setupConstraints()
        fetchPost()
    }
    
    func notifyViewWillAppear(){
        
    }
    
    func notifyViewDidAppear(){
        
    }
    
    func fetchPost() {
        interactor?.getCachedPosts()
    }
    
    func presentPosts(posts: [Post]) {
        self.posts = Array(Set(self.posts + posts))
        sortPosts()
        view?.showPosts(posts: self.posts)
    }
    
    func segmentedControlChanged(postFilter: PostFilter) {
        switch postFilter {
        case .all:
            view?.showPosts(posts: posts)
        case .favorites:
            let favoritePosts = posts.filter({$0.favorite == true})
            view?.showPosts(posts: favoritePosts)
        }
    }
    
    func deleteAllPressed() {
        posts = posts.filter({$0.favorite == true})
        view?.showPosts(posts: posts)
        cacheService.deleteAllPosts()
    }
    
    func pushDetail(post: Post) {
        router?.pushDetail(post: post, favoriteDelegate: self, deleteDelegate: self)
    }
    
    func sortPosts(){
        posts.sort(by: {($0.favorite ?? false) && !($1.favorite ?? false)})
    }
}

extension PostsPresenter: FavoriteDelegate{
    func updateFavoriteState(post: Post) {
        if let index = self.posts.firstIndex(where: {$0.id == post.id}) {
            posts[index].favorite = post.favorite
            sortPosts()
            view?.showPosts(posts: posts)
        }
    }
}

extension PostsPresenter: DeleteDelegate{
    func updateDeleteState(post: Post) {
        if let index = self.posts.firstIndex(where: {$0.id == post.id}) {
            posts.remove(at: index)
            sortPosts()
            view?.showPosts(posts: posts)
        }
    }
}

enum PostFilter: Int {
    case all = 0, favorites
}
