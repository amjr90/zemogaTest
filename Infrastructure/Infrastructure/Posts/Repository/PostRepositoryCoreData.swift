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
    
    public func savePosts(posts: [Post]) {
        let _ = PostTraslator().getPostEntities(posts: posts, context: persistentContainer.viewContext)
        savePersistentContainer()
    }
    
    public func deleteAllPosts() {
        do
        {
            var postEntities = try persistentContainer.viewContext.fetch(PostEntity.fetchRequest())
            postEntities = postEntities.filter({$0.favorite != true})
            for postEntity in postEntities {
                persistentContainer.viewContext.delete(postEntity)
            }
            savePersistentContainer()
        }
        catch{
            print(error)
        }
    }
    
    public func updatePost(post: Post) {
        do {
            let postEntities = try persistentContainer.viewContext.fetch(PostEntity.fetchRequest())
            let postEntity = postEntities.first(where: {$0.id == post.id})
            postEntity?.favorite = post.favorite ?? false
            
            savePersistentContainer()
        } catch  {
            print(error)
        }
    }
    
    public func deletePost(post: Post) {
        do{
            let postEntities = try persistentContainer.viewContext.fetch(PostEntity.fetchRequest())
            let postEntity = postEntities.first(where: {$0.id == post.id})
            
            persistentContainer.viewContext.delete(postEntity!)
            savePersistentContainer()
        }
        catch{
            print(error)
        }
        
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
