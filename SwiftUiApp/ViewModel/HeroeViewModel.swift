import Foundation
import Combine
import SwiftUI

class HeroViewModel: ObservableObject, HeroesViewModelType {
    
    @Published var state: HeroViewState = .idle
    private let heroUseCase: HeroUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: HeroUseCase) {
        self.heroUseCase = useCase
    }
    
    func transform(input: HeroViewModelInput) -> HeroViewModelOuput {
        input.appear.flatMap { [weak self] _ -> AnyPublisher<HeroViewState, Never> in
            guard let self = self else { return Just(.idle).eraseToAnyPublisher() }

            return self.heroUseCase.getHeroes()
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
    
    func fetchHeroes() {
        self.state = .idle
        heroUseCase.getHeroes()
            .map { heroes in
                    .success(heroes.data.results)
            }
            .catch { error in
                Just(.failure(error))
            }
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &cancellables)
    }
}
