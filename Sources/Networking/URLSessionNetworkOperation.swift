//
//  URLSessionNetworkOperation.swift
//  
//
//  Created by Alexandre Robaert on 17/06/23.
//

import Foundation

public class URLSessionNetworkOperation: NetworkOperation {
    
    private let session: URLSession
    
    public init(session: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: session)
    }
    
    public func fetch(_ urlRequest: URLRequest) async throws -> Data {
        
        let (data, response) = try await session.data(for: urlRequest)
        guard let response  = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch response.statusCode {
        case 204:
            throw NetworkError.noResponse
        case 200...299:
            return data
        case 403:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.unexpectedStatusCode
        }
    }
}
