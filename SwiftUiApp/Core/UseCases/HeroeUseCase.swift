import Combine

// MARK: - UseCase

/// Protocol specifying the task to retrieve heroes.
protocol HeroUseCase {
    func getHeroes()  -> AnyPublisher<MarvelResponse, APIError>

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

    func getHeroes() -> AnyPublisher<MarvelResponse, APIError> {
        apiClient.request(MarvelEndpoint.getHeroes(limit: Constants.limit))
            .mapError { _ in APIError.invalidResponse }
                       .eraseToAnyPublisher()
    }
}
