//
//  NetworkingService.swift
//  Networking
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public class NetworkingService: NetworkingRepository {
    private let repository: NetworkingRepository
    
    public init(repository: NetworkingRepository) {
        self.repository = repository
    }
    
    public func get(url: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        repository.get(url: url, completion)
    }
}
