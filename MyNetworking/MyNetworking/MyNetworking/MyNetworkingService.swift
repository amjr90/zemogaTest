//
//  NetworkingService.swift
//  Networking
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public class MyNetworkingService{
    private let repository: MyNetworkingRepository
    
    public init(repository: MyNetworkingRepository) {
        self.repository = repository
    }
    
    public func get(url: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        repository.get(url: url, completion)
    }
}
