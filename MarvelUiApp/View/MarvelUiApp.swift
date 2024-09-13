import SwiftUI

@main
struct MarvelUiApp: App {
    private let factory = ViewModelFactory()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: factory.createHeroViewModel())
        }
    }
}
