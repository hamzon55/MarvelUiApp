import Combine
import SwiftUI

protocol HeroesViewModelType: AnyObject {
    func transform(input: HeroViewModelInput) -> HeroViewModelOuput
}

enum HeroViewState {
    case idle
    case success([Character])
    case failure(Error)
    case error(String)
}

extension HeroViewState: Equatable {
    public static func == (lhs: HeroViewState, rhs: HeroViewState) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lhsSeries), .success(let rhsSeries)): return lhsSeries == rhsSeries
        case (.failure, .failure): return true
        default: return false
        }
    }
}

struct HeroViewModelInput {
    let appear: AnyPublisher<Void, Never>
    let search: AnyPublisher<String, Never>
}

typealias HeroViewModelOuput = AnyPublisher<HeroViewState, Never>
