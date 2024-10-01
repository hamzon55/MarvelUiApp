import SwiftUI
import Combine

struct HeroDetailView: View {
    
    @StateObject private var viewModel: HeroDetailViewModel
    private let appear = PassthroughSubject<Void, Never>()
    @State private var cancellables = Set<AnyCancellable>()
    
    init(heroItem: Character) {
        _viewModel = StateObject(wrappedValue: HeroDetailViewModel(heroItem: heroItem))
    }
    
    var body: some View {
        content
            .onAppear {
                let input = HeroDetailViewModelInput(appear: appear.eraseToAnyPublisher())
                let output = viewModel.transform(input: input)
                output
                    .sink { state in
                    }
                    .store(in: &cancellables)
                appear.send(())
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            ProgressView("Loading...")
                .onAppear {
                    appear.send(())
                }
        case .success(let character):
            HeroUiView(hero: character)
        case .error(let message):
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
