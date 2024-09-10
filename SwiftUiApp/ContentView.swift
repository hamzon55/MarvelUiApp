import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: HeroViewModel
    @State private var searchText = ""
    
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
                            viewModel.fetchHeroes(query: searchText)
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
        }
        .searchable(text: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HeroViewModel(useCase: DefaultHeroUseCase(apiClient: URLSessionAPIClient())))
    }
}
