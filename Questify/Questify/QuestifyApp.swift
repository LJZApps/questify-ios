//
//  QuestifyApp.swift
//  Questify
//
//  Created by Leon Zapke on 15.10.24.
//

import SwiftUI
import SwiftData

@main
struct QuestifyApp: App {
    @StateObject private var viewModel = MainViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([

        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if (!viewModel.isSetupDone) {
                HomeView()
            } else {
                GetStartedMainView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
