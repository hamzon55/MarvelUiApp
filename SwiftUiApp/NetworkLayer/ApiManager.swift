import Foundation
import Combine
class ApiManager: ApiManagerType {
    
    private var session: URLSession
    init(session: URLSession = URLSession.shared) {
        // dynamic session can be injected, will be helpful for testing
        self.session = session
    }
    
    func request<T: Decodable>(url: URL) -> AnyPublisher <T, ApiError> {
        self.session.dataTaskPublisher(for: url)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw ApiError.requestFailed
                }
                if (200..<300) ~= httpResponse.statusCode {
                    return result.data
                }
                throw ApiError.invalidResponse
            })
            .receive(on: RunLoop.main) // updates data on mainqueue
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> ApiError in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.decodingFailed
            })
            .eraseToAnyPublisher()
    }
}
