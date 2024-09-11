import SwiftUI

@main
struct SwiftUiApp: App {
    private let factory = ViewModelFactory()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: factory.createHeroViewModel())
        }
    }
}
