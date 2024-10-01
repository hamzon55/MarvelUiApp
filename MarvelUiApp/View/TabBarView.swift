
import SwiftUI
import Foundation

struct TabBarview: View {
    private let factory = ViewModelFactory()

    var body: some View {
        TabView {
            ContentView(viewModel: factory.createHeroViewModel(), factory: factory)
                .tabItem{
                    Label("Heroes", systemImage: "list.dash")
                }
            ContentView(viewModel: factory.createHeroViewModel(), factory: factory)
                .tabItem{
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
