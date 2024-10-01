final class ViewModelFactory {
    
    private let apiClient: URLSessionAPIClient<MarvelEndpoint>
    
    init(apiClient: URLSessionAPIClient<MarvelEndpoint> = URLSessionAPIClient<MarvelEndpoint>()) {
           self.apiClient = apiClient
       }
    
    func createHeroViewModel() -> HeroViewModel {
        let heroUseCase = DefaultHeroUseCase(apiClient: apiClient)
        return HeroViewModel(useCase: heroUseCase)
    }
}
    