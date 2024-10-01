import XCTest
import Combine
import Foundation

@testable import MarvelUiApp

class MockAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    var result: Result<Data, Error>?

    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: APIError.invalidResponse)
                .eraseToAnyPublisher()
        }

        switch result {
        case .success(let data):
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return Just(decodedObject)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: APIError.decodingError(error as! DecodingError))
                    .eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}


class MockURLProtocol: URLProtocol {
    // This closure will handle requests and return mock responses
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    // Determines whether the protocol can handle the given request
    override class func canInit(with request: URLRequest) -> Bool {
        // Intercept all requests
        return true
    }
    
    // Returns a canonical version of the request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // Start loading the request
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is not set.")
        }
        
        do {
            // Get the mock response and data
            let (response, data) = try handler(request)
            
            // Send the response to the client
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            // Send the data to the client
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            // Notify that loading is finished
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // Notify the client of the error
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    // Stop loading the request
    override func stopLoading() {
        // Required method; implement if necessary
    }
}
