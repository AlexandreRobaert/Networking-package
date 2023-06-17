
import Foundation

public protocol Request {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var port: Int? { get }
    var method: HttpMethod { get }
    var headers: [String: Any]? { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

extension Request {
    var scheme: String {
        "https"
    }
    
    var baseURL: String {
        "localhost"
    }
    
    var port: Int? {
        8080
    }
    
    var token: String {
        ""
    }
    
    var method: HttpMethod {
        .get
    }
    
    var mockFile: String? {
        return nil
    }
}
