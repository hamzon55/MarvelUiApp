import Foundation
import Combine
import SwiftUI

class HeroViewModel: ObservableObject, HeroesViewModelType {
    
    @Published var state: HeroViewState = .idle
    private let useCase: HeroUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: HeroUseCase) {
        self.useCase = useCase
    }
    
    
    func transform(input: HeroViewModelInput) -> HeroViewModelOuput {
        cancellables.forEach { $0.cancel()}
        cancellables.removeAll()
        
        // MARK: - on View Appear
        let onAppearResults = input.appear
            .flatMap { [weak self] _ -> AnyPublisher<HeroViewState, Never> in
                guard let self = self else { return Just(.idle).eraseToAnyPublisher() }
                
                return self.useCase.fetchHeroes(query: nil)
                    .map { heroes in
                            .success(heroes.data.results)
                    }
                    .catch { error in
                        Just(.failure(error))
                    }
                    .eraseToAnyPublisher()
            }
        
        // MARK: - Handle Searching
        let onSearchAction = input.search
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
        
        let searchResults = onSearchAction
            .flatMap { [weak self] query -> AnyPublisher<HeroViewState, Never> in
                guard let self = self else { return Just(.idle).eraseToAnyPublisher() }
                return self.useCase.fetchHeroes(query: query)
                    .map { heroes in
                            .success(heroes.data.results)
                    }
                    .catch { error in
                        Just(.failure(error))
                    }
                    .eraseToAnyPublisher()
            }
        // Merge the appear and search results, handle state updates
        return Publishers.Merge(onAppearResults, searchResults)
            .handleEvents(receiveOutput: { [weak self] state in
                self?.state = state // Updating the view state when new data is received
            })
            .eraseToAnyPublisher()
    }
    
    func fetchHeroes(query: String?) {
        self.state = .idle
        useCase.fetchHeroes(query: query)
            .map { heroes in
                    .success(heroes.data.results)
            }
            .catch { error in
                Just(.failure(error))
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }
}
