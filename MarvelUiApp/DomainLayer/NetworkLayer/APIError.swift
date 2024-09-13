import Foundation
enum APIError: Error {
    case networkError(URLError)
    case decodingError(DecodingError)
    case invalidResponse
}
