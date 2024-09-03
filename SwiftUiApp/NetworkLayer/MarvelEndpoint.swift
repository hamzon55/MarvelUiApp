import Foundation

enum MarvelEndpoint: APIEndpoint {
    
    case getHeroes(limit: Int)

    var baseURL: URL {
        return MarvelConstants.baseUrl
    }
    
    var path: String {
        switch self {
        case .getHeroes:
            return MarvelConstants.characterPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getHeroes:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [
            "ts": MarvelConstants.timestamp,
            "apikey": MarvelConstants.publicKey,
            "hash": MarvelConstants.hash
        ]
        
        switch self {
        case let .getHeroes(limit):
            params["limit"] = limit
        }
        
        return params.isEmpty ? nil : params
    }
}
