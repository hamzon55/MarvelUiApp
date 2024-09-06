import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: HeroViewModel
    
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
                            viewModel.fetchHeroes()
                        }
                    
                case .success(let heroes):
                    List(heroes) { hero in
                        HeroCell(hero: hero)
                    }
                    
                case .failure(let error):
                    Text("Failed to load heroes: \(error.localizedDescription)")
                    
                case .error(let message):
                    Text("Error: \(message)")
                }
            }
            .navigationTitle("Heroes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HeroViewModel(useCase: DefaultHeroUseCase(apiClient: URLSessionAPIClient())))
    }
}

struct CircularProgressView: View {
    var body: some View {
        Circle()
            .stroke( // 1
                Color.pink.opacity(0.5),
                lineWidth: 30
            )
    }
}
