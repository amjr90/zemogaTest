//
//  NetworkingProtocol.swift
//  Networking
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public protocol NetworkingRepository {
    func get(url: String, _ completion: @escaping (Result<Data, Error>)->Void)
}
