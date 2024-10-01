import Combine
import SwiftUI

class HeroDetailViewModel: ObservableObject, HeroesDetailViewModelType {
    
    @Published var state: HeroDetailViewState = .idle
    private var cancellables = Set<AnyCancellable>()
    private let heroItem: Character
    
    private enum Constants {
        enum ErrorMessage {
            static let selfError = "Self should not be nil"
        }
    }
    init(heroItem: Character) {
        self.heroItem = heroItem
    }
    
    func transform(input: HeroDetailViewModelInput) -> HeroDetailViewModelOuput {
        let heroDetailModel = input.appear
            .map { [weak self] () -> HeroDetailViewState in
                guard let self = self else { return .error(Constants.ErrorMessage.selfError) }
                return .success(self.heroItem)
            }
            .eraseToAnyPublisher()
        heroDetailModel
            .receive(on: DispatchQueue.main)
            .assign(to: &$state) 
        return heroDetailModel
    }
}
