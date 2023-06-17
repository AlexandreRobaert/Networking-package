//
//  AlamofireNetworkOperation.swift
//  
//
//  Created by Alexandre Robaert on 17/06/23.
//

import Foundation
import Alamofire

public class AlamofireNetworkOperation: NetworkOperation {
    public func fetch(_ urlRequest: URLRequest) async throws -> Data {
        
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(urlRequest).validate(statusCode: 200...299).response { response in
                switch response.result {
                case .success(let dataResponse):
                    guard let dataResponse else {
                        return continuation.resume(throwing: NetworkError.noResponse)
                    }
                    continuation.resume(returning: dataResponse)
                case .failure(let afError):
                    continuation.resume(throwing: self.handlerError(afError))
                }
            }
        })
    }
    
    private func handlerError(_ error: AFError) -> NetworkError {
        
        return .decode
    }
}
