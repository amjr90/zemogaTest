//
//  PostsRepository.swift
//  Domain
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public protocol PostsRepository: AnyObject {
    func getPosts(completion: @escaping (Result<[Post], Error>)->Void)
    func getComments(postId: Int, completion: @escaping (Result<[Comment], Error>)->Void)
    func getUserInfo(userId: Int, completion: @escaping (Result<User, Error>)->Void)
    func cachePost(posts: [Post])
}

public protocol PostsRepositoryCache: AnyObject{
    func getPosts(completion: @escaping (Result<[Post], Error>)->Void)
    func savePosts(posts: [Post])
    func deleteAllPosts()
    func deletePost(post: Post)
    func updatePost(post: Post)
}
