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
                       Text("Loading...")
                           .onAppear {
                               viewModel.fetchHeroes()
                           }
                       
                   case .success(let heroes):
                       List(heroes, id: \.id) { hero in
                           Text(hero.name) 
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
