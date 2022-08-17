//
//  Post.swift
//  Domain
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public struct Post: Codable {
    let userId, id: Int
    let title, body: String
}
