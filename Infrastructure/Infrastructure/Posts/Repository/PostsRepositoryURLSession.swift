//
//  PostsRepositoryURLSession.swift
//  Infrastructure
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation
import Domain
import MyNetworking
import CoreData
public class PostsRepositoryURLSession{
    let service = MyNetworkingService(repository: MyNetworkingURLSession())
    
    public init(){}
     
    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        service.get(url: url) { result in
            switch result{
            case .success(let data):
                do{
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                }
                catch{
                    completion(.failure(.invalidData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        service.get(url: url) { result in
            switch result{
            case .success(let data):
                do{
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    completion(.success(comments))
                }
                catch{
                    completion(.failure(.invalidData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getUserInfo(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users/\(userId)"
        service.get(url: url) { result in
            switch result{
            case .success(let data):
                do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                }
                catch{
                    completion(.failure(.invalidData))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
