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
