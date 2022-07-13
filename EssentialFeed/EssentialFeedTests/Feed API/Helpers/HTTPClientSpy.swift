//
//  HTTPClientSpy.swift
//  EssentialFeedTests
//
//  Created by Marcos Reboucas on 13/07/22.
//

import Foundation
import EssentialFeed

class HTTPClientSpy: HTTPClient {
    private struct Task: HTTPClientTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
    private(set) var cancelledURLs = [URL]()
    
    var requestedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
        
    }
}

// Ele cria o array de tuples 'messages' que tem uma referencia ao result 'completion'.
// Ao chamar 'get' ele cria uma referencia entre o completion da chamada 'get' e o completion do array 'messages'.
// Ao chamar 'complete' e colocar o 'error' no array 'messages' ele tambem coloca o 'error' no  completion da chamada get automaticamente (reference type).
