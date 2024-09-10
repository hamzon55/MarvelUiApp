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
        input.appear.flatMap { [weak self] _ -> AnyPublisher<HeroViewState, Never> in
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
        .receive(on: DispatchQueue.main)
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
