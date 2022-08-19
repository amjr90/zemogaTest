//
//  Comment.swift
//  Domain
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public struct Comment: Codable {
    public let postId, id: Int
    public let name, email, body: String
}
