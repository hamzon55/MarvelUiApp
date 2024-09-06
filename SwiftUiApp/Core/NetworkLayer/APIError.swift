enum APIError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "Server is not reachable"
        case .badURL:
            return "Not a valid URL"
        case .decodingFailed:
            return "Json failed"
        case .invalidResponse:
            return "Response type not a json"
        }
    }
}

