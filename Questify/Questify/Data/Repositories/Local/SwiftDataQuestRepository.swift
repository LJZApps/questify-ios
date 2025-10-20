//
//  SwiftDataQuestRepository.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation
import SwiftData

enum QuestDataError: Error {
    case questNotFound
    case couldNotSave
}

@MainActor
final class SwiftDataQuestRepository: QuestRepositoryProtocol {
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    private var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    func fetchAllQuests() async throws -> [Quest] {
        let descriptor = FetchDescriptor<QuestDataModel>()
        let dataModels = try modelContext.fetch(descriptor)
        
        return dataModels.map { $0.toDomain() }
    }
    
    func save(quest: Quest) async throws {
        let dataModel = quest.toDataModel()
        
        // Speichere das Model im Kontext
        modelContext.insert(dataModel)
        
        do {
            // Speichere die Änderungen persistent
            try modelContext.save()
        } catch {
            print("[\(Self.self)] Fehler beim Speichern: \(error)")
            throw QuestDataError.couldNotSave
        }
    }
    
    func fetchQuest(id: UUID) async throws -> Quest? { nil }
    func update(quest: Quest) async throws {
        // Implementierung folgt
        print("TODO")
    }
    func delete(id: UUID) async throws {}
}
