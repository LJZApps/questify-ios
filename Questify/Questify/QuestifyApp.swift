//
//  QuestifyApp.swift
//  Questify
//
//  Created by Leon Zapke on 15.10.24.
//

import SwiftUI
import SwiftData

let appSchema = Schema([
    QuestDataModel.self
])

@main
struct QuestifyApp: App {
    let sharedModelContainer: ModelContainer = {
        let modelConfiguration = ModelConfiguration(schema: appSchema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: appSchema, configurations: [modelConfiguration])
        } catch {
            fatalError("FATAL ERROR: SwiftData Container konnte nicht geladen werden: \(error)")
        }
    }()
    
    private let questFeatureFactory: QuestFeatureFactoryProtocol
    
    init() {
        // Data Layer: Das konkrete Repository (Implementierung)
        let concreteRepository = SwiftDataQuestRepository(modelContainer: sharedModelContainer)
        
        // Domain Layer: Der Use Case (Geschäftslogik)
        let createQuestUseCase = CreateNewQuestUseCase(questRepository: concreteRepository)
        
        // Presentation Layer: Die Factory, die Views/ViewModels baut
        self.questFeatureFactory = QuestFeatureFactory(createQuestUseCase: createQuestUseCase)
    }

    var body: some Scene {
        #if os(iOS)
        if (!viewModel.isSetupDone) {
            HomeScene()
        } else {
            GetStartedMainView()
        }
        .modelContainer(sharedModelContainer)
        
        #elseif os(macOS)
        Settings {
            
        }
        #endif
    }
}
