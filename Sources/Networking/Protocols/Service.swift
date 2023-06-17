//
//  File.swift
//  
//
//  Created by Alexandre Robaert on 10/06/23.
//

import Foundation

public protocol Service {
    var networkOperation: NetworkOperation { get }
    func request<T>(_ request: Request) async throws -> T where T: Decodable
}

extension Service {
    private func convertRequest(_ request: Request) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.baseURL
        urlComponents.port = request.port
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach({ value in
            urlRequest.addValue(String(describing: value.value), forHTTPHeaderField: value.key)
        })
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        if !request.token.isEmpty {
            urlRequest.addValue("Bearer \(request.token)", forHTTPHeaderField: "Authorization")
        }
        if let body = request.body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                throw NetworkError.malformedBody
            }
        }
        return urlRequest
    }
    
    public func request<T>(_ request: Request) async throws -> T where T: Decodable {
        let urlRequest = try convertRequest(request)
        let data = try await networkOperation.fetch(urlRequest)
        guard let model = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decode
        }
        return model
    }
}
