//
//  PostRepositoryCoreData.swift
//  Infrastructure
//
//  Created by andres jaramillo on 19/08/22.
//

import Foundation
import Domain
import CoreData
import UIKit

public class PostRepositoryCoreData: PostsRepositoryCache {
    
    let modelName = "PostsModel"
    
    public init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let frameworkBundle = Bundle(for: PostRepositoryCoreData.self)
        let modelURL = frameworkBundle.url(forResource: self.modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        do
        {
            let postEntities = try persistentContainer.viewContext.fetch(PostEntity.fetchRequest())
            let posts = PostTraslator().getPosts(postEntities: postEntities)
            completion(.success(posts))
        }
        catch{
            completion(.failure(error))
        }
    }
    
    public func savePosts(posts: [Post], result: Bool) {
        let _ = PostTraslator().getPostEntities(posts: posts, context: persistentContainer.viewContext)
        savePersistentContainer()
    }
    
    public func deleteAllPosts(result: Bool) {
        let _ = persistentContainer.viewContext.deletedObjects
        savePersistentContainer()
    }
    
    public func updatePost(post: Post) {
        let _ = PostTraslator().postDomainToPostEntity(post: post, context: persistentContainer.viewContext)
        
        savePersistentContainer()
    }
    
    public func deletePost(post: Post) {
        let postEntity = PostTraslator().postDomainToPostEntity(post: post, context: persistentContainer.viewContext)
        
        persistentContainer.viewContext.delete(postEntity)
        savePersistentContainer()
    }
    
    func savePersistentContainer(){
        do
        {
           try persistentContainer.viewContext.save()
        }
        catch{
            print(error)
        }
    }
}
