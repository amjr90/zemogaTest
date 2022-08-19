//
//  PostsRouter.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 17/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

class PostsRouter: PostsRouterProtocol {
    var navigation: UINavigationController?
    
    static func createModule(with navigation: UINavigationController) -> PostsViewController {
       
        var view: PostsViewProtocol = PostsViewController()
        var interactor: PostsInteractorProtocol = PostsInteractor()
        let presenter: PostsPresenterProtocol = PostsPresenter()
        
        let router = PostsRouter()
        router.navigation = navigation
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        return view as! PostsViewController
    }
    
    func pushDetail(post: Post, favoriteDelegate: FavoriteDelegate, deleteDelegate: DeleteDelegate) {
        let postDetailVC = PostsDetailRouter.createModule(with: navigation!,post: post, favoriteDelegate: favoriteDelegate, deleteDelegate: deleteDelegate)
        navigation?.pushViewController(postDetailVC, animated: true)
    }
}
