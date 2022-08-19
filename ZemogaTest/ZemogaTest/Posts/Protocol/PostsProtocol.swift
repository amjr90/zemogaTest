//
//  PostsProtocol.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 17/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

protocol PostsViewProtocol: AnyObject {
    var presenter:PostsPresenterProtocol? {get set}
    
    func setTitle()
    func setupView()
    func setupTableView()
    func setupConstraints()
    func showPosts(posts: [Post])
}

protocol PostsInteractorProtocol: AnyObject {
    var presenter:PostsPresenterProtocol? {get set}
    
    func getCachedPosts()
    func fetchPosts()
}

protocol PostsPresenterProtocol: AnyObject {
    var router: PostsRouterProtocol? {get set}
    var interactor: PostsInteractorProtocol? {get set}
    var view: PostsViewProtocol? {get set}
    
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func notifyViewDidAppear()
    func fetchPost()
    func presentPosts(posts: [Post])
    func segmentedControlChanged(postFilter:PostFilter)
    func deleteAllPressed()
    func pushDetail(post: Post)
}

protocol PostsRouterProtocol: AnyObject {
    var navigation: UINavigationController? {get set}
    static func createModule(with navigation: UINavigationController) -> PostsViewController
    func pushDetail(post: Post, favoriteDelegate: FavoriteDelegate, deleteDelegate: DeleteDelegate)
}
