//
//  PostsDetailProtocol.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

protocol PostsDetailViewProtocol: AnyObject {
    var presenter:PostsDetailPresenterProtocol? {get set}
    
    func setTitle()
    func setupView()
    func setupConstrains()
    func setupCommentsTableView()
    func setInfo(post: Post)
    func setUserInfo(user: User)
    func setComments(comments: [Comment])
    func updateFavoriteState(value: Bool)
}

protocol PostsDetailInteractorProtocol: AnyObject {
    var presenter:PostsDetailPresenterProtocol? {get set}
    
    func getUserInfo(userId: Int)
    func getComents(postId: Int)
}

protocol PostsDetailPresenterProtocol: AnyObject {
    var router: PostsDetailRouterProtocol? {get set}
    var interactor: PostsDetailInteractorProtocol? {get set}
    var view: PostsDetailViewProtocol? {get set}
    var post: Post? {get set}
    var favoriteDelegate: FavoriteDelegate? {get set}
    var deleteDelegate: DeleteDelegate? {get set}
    
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func notifyViewDidAppear()
    func presentUserInfo(user: User)
    func presentComments(comments: [Comment])
    func favoriteTap()
    func deleteTap()
}

protocol PostsDetailRouterProtocol: AnyObject {
    var navigation: UINavigationController? {get set}
    static func createModule(with navigation:UINavigationController, post: Post, favoriteDelegate: FavoriteDelegate, deleteDelegate: DeleteDelegate) -> PostsDetailViewController
    func popViewController()
}
