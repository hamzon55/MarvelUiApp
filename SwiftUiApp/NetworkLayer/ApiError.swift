enum ApiError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case customError(ErrorModel)
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
        case .customError(let model):
            return model.message
        }
    }
}

