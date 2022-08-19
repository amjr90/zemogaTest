//
//  MyNetworkingTests.swift
//  MyNetworkingTests
//
//  Created by andres jaramillo on 17/08/22.
//

import XCTest
@testable import MyNetworking

class MyNetworkingTests: XCTestCase {

    func test_url_deliversFailureInvalidURlError() throws {
        let service = MyNetworkingService(repository: MyNetworkingURLSession())
        let url = ""
       
        service.get(url: url) { result in
            switch result{
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            default:
                break
            }
        }
    }
    
    func test_url_deliversSuccessData() throws {
        let service = MyNetworkingService(repository: MyNetworkingURLSession())
        let url = "https://jsonplaceholder.typicode.com/posts"
       
        let expectation = XCTestExpectation(description: #function)

        service.get(url: url) { result in
            expectation.fulfill()
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func test_url_deliversInvalidData() throws {
        let service = MyNetworkingService(repository: MyNetworkingURLSession())
        let url = "https://jsonplaceholder.com/posts"
       
        let expectation = XCTestExpectation(description: #function)

        service.get(url: url) { result in
            expectation.fulfill()
            switch result{
            case .failure(let error):
                XCTAssertEqual(error, .invalidData)
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }

}
