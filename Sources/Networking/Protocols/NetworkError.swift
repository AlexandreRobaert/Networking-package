//
//  File.swift
//  
//
//  Created by Alexandre Robaert on 10/06/23.
//

import Foundation

public enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case malformedBody
    case unknown
}
