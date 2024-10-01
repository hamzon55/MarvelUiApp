import Combine
import Foundation

// MARK: - UseCase

/// Protocol specifying the task to retrieve heroes.
protocol HeroUseCase {
    func fetchHeroes(query: String?)  -> AnyPublisher<MarvelResponse, Error>

}

final class DefaultHeroUseCase: HeroUseCase {
 
    
    private enum Constants {
        static let limit = 20
    }
       
    private let apiClient: URLSessionAPIClient<MarvelEndpoint>

    /// - Parameter apiClient: The API client for making network requests.
    init(apiClient: URLSessionAPIClient<MarvelEndpoint>) {
          self.apiClient = apiClient
      }
    
    /// Retrieves heroes based on the provided query.
    /// - Returns: A publisher emitting `MarvelResponse` or a `HeroUseCaseError` if an error occurs.

    func fetchHeroes(query: String?) -> AnyPublisher<MarvelResponse, Error> {
        apiClient.request(MarvelEndpoint.getHeroes(limit: Constants.limit, query: query))
    }
}
