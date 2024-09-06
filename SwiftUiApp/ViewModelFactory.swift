class ViewModelFactory {
    
    private let apiClient: URLSessionAPIClient<MarvelEndpoint>
    
    init() {
        self.apiClient = URLSessionAPIClient<MarvelEndpoint>()
    }
    
    func createHeroViewModel() -> HeroViewModel {
        let heroUseCase = DefaultHeroUseCase(apiClient: apiClient)
        return HeroViewModel(useCase: heroUseCase)
    }
}
