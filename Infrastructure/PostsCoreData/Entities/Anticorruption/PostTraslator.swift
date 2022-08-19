//
//  PostToPostEntityTraslator.swift
//  Infrastructure
//
//  Created by andres jaramillo on 19/08/22.
//

import Foundation
import Domain
import CoreData

class PostTraslator{
    func postDomainToPostEntity(post: Post, context: NSManagedObjectContext)->PostEntity{
        let postEntity = PostEntity(context: context)
        postEntity.userId = Int32(post.userId)
        postEntity.id = Int32(post.id)
        postEntity.title = post.title
        postEntity.body = post.body
        postEntity.favorite = post.favorite ?? false
        
        return postEntity
    }
    
    func postEntityToPostDomain(postEntity: PostEntity)->Post{
        let post = Post(userId: Int(postEntity.userId), id: Int(postEntity.id), title: postEntity.title ?? "", body: postEntity.body ?? "", favorite: postEntity.favorite)
        
        return post
    }
    
    func getPosts(postEntities: [PostEntity])->[Post]{
        var posts = [Post]()
        
        for item in postEntities {
            posts.append(postEntityToPostDomain(postEntity: item))
        }
        
        return posts
    }
    
    func getPostEntities(posts: [Post], context: NSManagedObjectContext)->[PostEntity]{
        var postEntities = [PostEntity]()
        
        for item in posts {
            postEntities.append(postDomainToPostEntity(post: item, context: context))
        }
        
        return postEntities
    }
}


//func domainToEntity(registro: Registro)->RegistroMotoEntity{
//    let registroEntity = RegistroMotoEntity()
//    registroEntity.id = registro._id
//    registroEntity.fechaIngreso = registro.getFechaIngreso()
//    registroEntity.vehiculo = MotoTraslator().domainToEntity(moto: registro.getVehiculo() as! Moto)
//
//    return registroEntity
//}
//
//func entityToDomain(registroEntity: RegistroMotoEntity)->Registro{
//    return try! Registro(id: registroEntity.id!, fechaIngreso: registroEntity.fechaIngreso!, vehiculo: MotoTraslator().entityToDomain(vehiculoEntity: registroEntity.vehiculo!))
//}
//
//func getObjects(registrosMotosEntities: Results<RegistroMotoEntity>)->[Registro]
//{
//    var registros = [Registro]()
//
//    for entity in registrosMotosEntities {
//        let registro = entityToDomain(registroEntity: entity)
//        registros.append(registro)
//    }
//
//    return registros
//}
