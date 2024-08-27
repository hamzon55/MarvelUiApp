import Foundation
import Combine

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {

    private var session: URLSession
    init(session: URLSession = URLSession.shared) {
        // dynamic session can be injected, will be helpful for testing
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
           let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
           var request = URLRequest(url: url)
           request.httpMethod = endpoint.method.rawValue
           
           endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
           // set up any other request parameters here
           
           return URLSession.shared.dataTaskPublisher(for: request)
               .subscribe(on: DispatchQueue.global(qos: .background))
               .tryMap { data, response -> Data in
                   guard let httpResponse = response as? HTTPURLResponse,
                         (200...299).contains(httpResponse.statusCode) else {
                       throw APIError.invalidResponse
                   }
                   return data
               }
               .decode(type: T.self, decoder: JSONDecoder())
               .eraseToAnyPublisher()
       }
   }
