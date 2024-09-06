//
//  SwiftUiAppApp.swift
//  SwiftUiApp
//
//  Created by Hamza Jerbi on 26/8/24.
//

import SwiftUI

@main
struct SwiftUiApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = URLSessionAPIClient<MarvelEndpoint>() // Create API client
            let heroUseCase = DefaultHeroUseCase(apiClient: apiClient) // Create HeroUseCase
            let heroViewModel = HeroViewModel(useCase: heroUseCase) // Create ViewModel
            ContentView(viewModel: heroViewModel)
        }
    }
}
