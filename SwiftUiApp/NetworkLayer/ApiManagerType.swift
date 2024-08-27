import Foundation
import Combine

protocol ApiManagerType {
    
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, ApiError>
}
