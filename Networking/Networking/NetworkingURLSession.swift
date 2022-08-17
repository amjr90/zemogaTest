//
//  NetworkingURLSession.swift
//  Networking
//
//  Created by andres jaramillo on 17/08/22.
//

import Foundation

public class NetworkingURLSession: NetworkingRepository {
    public init(){}
    
    public func get(url: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: url){
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode{
                    case 200, 201:
                        DispatchQueue.main.async {
                            completion(.success(data!))
                        }
                        
                    default:
                        DispatchQueue.main.async {
                            completion(.failure(.invalidData))
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        completion(.failure(.invalidData))
                    }
                }
            }
            task.resume()
        }
        else{
            completion(.failure(.invalidURL))
        }
    }
}

public enum Error: Swift.Error{
    case invalidURL
    case connectivity
    case invalidData
}
