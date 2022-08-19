//
//  PostsDetailRouter.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

class PostsDetailRouter: PostsDetailRouterProtocol {
    var navigation: UINavigationController?
    
    static func createModule(with navigation:UINavigationController, post: Post, favoriteDelegate: FavoriteDelegate, deleteDelegate: DeleteDelegate) -> PostsDetailViewController {
       
        var view: PostsDetailViewProtocol = PostsDetailViewController()
        var interactor: PostsDetailInteractorProtocol = PostsDetailInteractor()
        let presenter: PostsDetailPresenterProtocol = PostsDetailPresenter()
        
        let router = PostsDetailRouter()
        router.navigation = navigation
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.post = post
        presenter.favoriteDelegate = favoriteDelegate
        presenter.deleteDelegate = deleteDelegate
        
        
        return view as! PostsDetailViewController
    }
    
    func popViewController() {
        navigation?.popViewController(animated: true)
    }
}
