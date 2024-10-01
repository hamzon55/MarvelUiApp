
import SwiftUI
import Foundation

struct TabBarview: View {
    private let factory = ViewModelFactory()

    var body: some View {
        TabView {
            ContentView(viewModel: factory.createHeroViewModel(), factory: factory)
                .tabItem{
                    Label(HeroText.HeroTab, systemImage: "list.dash")
                }
            ContentView(viewModel: factory.createHeroViewModel(), factory: factory)
                .tabItem{
                    Label(HeroText.favTab, systemImage: "star.fill")
                }
        }
    }
}
