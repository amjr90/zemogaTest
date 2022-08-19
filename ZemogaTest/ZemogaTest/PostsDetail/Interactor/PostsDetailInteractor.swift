//
//  PostsDetailInteractor.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//
//  This template was created by AMJR
//

import Foundation
import Infrastructure

class PostsDetailInteractor: PostsDetailInteractorProtocol {
    
    weak var presenter: PostsDetailPresenterProtocol?
    
    let service = PostsRepositoryURLSession()
    
    func getUserInfo(userId: Int) {
        service.getUserInfo(userId: userId) { result in
            switch result{
            case .success(let user):
                self.presenter?.presentUserInfo(user: user)
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getComents(postId: Int) {
        service.getComments(postId: postId) { result in
            switch result{
            case .success(let comments):
                self.presenter?.presentComments(comments: comments)
                break
            case .failure(let error):
                break
            }
        }
    }
}
