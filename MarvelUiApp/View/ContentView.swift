import SwiftUI
import Combine
struct ContentView: View {
    
    @StateObject private var viewModel: HeroViewModel
    @State private var searchText = ""
    @State private var cancellables = Set<AnyCancellable>()

    private let onSearchPublisher = PassthroughSubject<String, Never>()
    private let onAppearPublisher = PassthroughSubject<Void,Never>()
    
    init(viewModel: HeroViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                switch viewModel.state {
                case .idle:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .onAppear {
                            onAppearPublisher.send()
                        }
                    
                case .success(let heroes):
                    List(heroes) { hero in
                        NavigationLink(destination: HeroDetailView(hero: hero)) {
                            HeroCell(hero: hero)
                        }
                    }
                case .failure(let error):
                    Text("Failed to load heroes: \(error.localizedDescription)")
                    
                case .error(let message):
                    Text("Error: \(message)")
                }
            }
            .navigationTitle("Heroes")
            .onAppear {
                
                let input = HeroViewModelInput(
                    appear: onAppearPublisher.eraseToAnyPublisher(),
                    search: onSearchPublisher.eraseToAnyPublisher()
                )
                let output = viewModel.transform(input: input)
                
                output.sink(receiveValue: { state in
                    viewModel.state = state 
                })
                .store(in: &cancellables)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            onSearchPublisher.send(newValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HeroViewModel(useCase: DefaultHeroUseCase(apiClient: URLSessionAPIClient())))
    }
}

