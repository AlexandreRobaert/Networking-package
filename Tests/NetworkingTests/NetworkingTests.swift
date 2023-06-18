import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {
    
    func testExample() async throws {
        let sut = TestService()
        let body = TestBody(name: "Alexandre teste", age: 36)
        let response: HomeResponse = try await sut.request(TestRequest.testPost(body: body))
        XCTAssertEqual(response.title, "titleTeste")
    }
}

extension NetworkingTests {
    
    struct HomeResponse: Decodable {
        let title: String
    }
    
    struct TestBody: Encodable {
        let name: String
        let age: UInt8
    }
    
    enum TestRequest: Request {
        
        case home
        case testPost(body: TestBody)
        
        var scheme: String {
            return "http"
        }
        
        var baseURL: String {
            return "localhost"
        }
        
        var path: String {
            switch self {
            case .home:
                return "/teste"
            case .testPost:
                return "/testepost"
            }
        }
        
        var method: HttpMethod {
            switch self {
            case .home:
                return .get
            case .testPost:
                return .post
            }
        }
        
        var port: Int? {
            80
        }
        
        var queryItems: [URLQueryItem]? {
            [URLQueryItem(name: "queryName", value: "queryItem")]
        }
        
        var body: [String : Any]? {
            if case .testPost(let body) = self {
                return body.toDictionary
            }
            return nil
        }
        
        var headers: [String : Any]? {
            if case .testPost = self {
                return ["httpMethodTest": self.method.rawValue]
            }
            return nil
        }
    }
    
    class TestService: Service {
        var networkOperation: Networking.NetworkOperation
        
        init(networkOperation: Networking.NetworkOperation = URLSessionNetworkOperation()) {
            self.networkOperation = networkOperation
        }
    }
}
