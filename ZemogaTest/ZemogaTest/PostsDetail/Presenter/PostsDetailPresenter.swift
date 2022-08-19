//
//  PostsDetailPresenter.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//
//  This template was created by AMJR
//

import Foundation
import Domain
import Infrastructure

class PostsDetailPresenter: PostsDetailPresenterProtocol {
    
    var router: PostsDetailRouterProtocol?
    var interactor: PostsDetailInteractorProtocol?
    weak var view: PostsDetailViewProtocol?

    var post: Post?
    var favoriteDelegate: FavoriteDelegate?
    var deleteDelegate: DeleteDelegate?
    
    let cacheService = PostRepositoryCoreData()
    
    func notifyViewLoaded(){
        view?.setTitle()
        view?.setupView()
        view?.setupConstrains()
        view?.setupCommentsTableView()
        if let post = post {
            view?.setInfo(post: post)
            interactor?.getUserInfo(userId: post.userId)
            interactor?.getComents(postId: post.id)
        }
    }
    
    func notifyViewWillAppear(){
        
    }
    
    func notifyViewDidAppear(){
        
    }
    
    func presentUserInfo(user: User) {
        view?.setUserInfo(user: user)
    }
    
    func presentComments(comments: [Comment]) {
        view?.setComments(comments: comments)
    }
    
    func favoriteTap() {
        if var favorite = post?.favorite{
            favorite = !favorite
            post?.favorite = favorite
        }
        else{
            post?.favorite = true
        }
        view?.updateFavoriteState(value: post?.favorite ?? true)
        if let post = post {
            cacheService.updatePost(post: post)
            favoriteDelegate?.updateFavoriteState(post: post)
        }
    }
    
    func deleteTap() {
        if let post = post {
            cacheService.deletePost(post: post)
            deleteDelegate?.updateDeleteState(post: post)
            router?.popViewController()
        }
    }
}

protocol FavoriteDelegate{
    func updateFavoriteState(post: Post)
}

protocol DeleteDelegate{
    func updateDeleteState(post: Post)
}
