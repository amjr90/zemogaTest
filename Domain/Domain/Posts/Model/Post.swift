//
//  Post.swift
//  Domain
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public struct Post: Codable, Hashable {
    public let userId, id: Int
    public let title, body: String
    public var favorite: Bool?
    
    public init(userId: Int, id: Int, title: String, body: String, favorite: Bool? = false){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.favorite = favorite
    }
}
