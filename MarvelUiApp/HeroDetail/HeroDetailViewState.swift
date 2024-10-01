import Combine
import SwiftUI

protocol HeroesDetailViewModelType: AnyObject {
    func transform(input: HeroDetailViewModelInput) -> HeroDetailViewModelOuput
}

enum HeroDetailViewState {
    case idle
    case success(Character)
    case error(String)

}

extension HeroDetailViewState {
    static func == (lhs: HeroDetailViewState, rhs: HeroDetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.success(let lhsSeries), .success(let rhsSeries)):
            return lhsSeries == rhsSeries
        default:
            return false
        }
    }
}

struct HeroDetailViewModelInput {
    let appear: AnyPublisher<Void, Never>
}

typealias HeroDetailViewModelOuput = AnyPublisher<HeroDetailViewState, Never>
