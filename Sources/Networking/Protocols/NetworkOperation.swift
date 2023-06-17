//
//  NetworkOperation.swift
//
//
//  Created by Alexandre Robaert on 10/06/23.
//

import Foundation

public protocol NetworkOperation {
    func fetch(_ urlRequest: URLRequest) async throws -> Data
}
