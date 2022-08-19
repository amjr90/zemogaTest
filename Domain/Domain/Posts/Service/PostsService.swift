//
//  PostsService.swift
//  Domain
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public class PostsService {
    private let repository: PostsRepository
    
    public init(repository: PostsRepository){
        self.repository = repository
    }
    
    public func getPosts(completion: @escaping (Result<[Post], Error>)->Void) {
        repository.getPosts(completion: completion)
    }
    
    public func getComments(postId: Int, completion: @escaping (Result<[Comment], Error>)->Void) {
        repository.getComments(postId: postId,completion: completion)
    }
    
    public func getUserInfo(userId: Int, completion: @escaping (Result<User, Error>)->Void){
        repository.getUserInfo(userId: userId, completion: completion)
    }
}
