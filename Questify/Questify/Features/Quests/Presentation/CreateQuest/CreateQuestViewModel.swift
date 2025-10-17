//
//  CreateQuestViewModel.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation
import Observation

@Observable
final class CreateQuestViewModel {
    var state = CreateQuestUiState()
    
    private let createQuestUseCase: CreateNewQuestUseCaseProtocol
    
    init(createQuestUseCase: CreateNewQuestUseCaseProtocol) {
        self.createQuestUseCase = createQuestUseCase
    }
    
    // MARK: - User Intent / Event Handling
    
    func saveQuest() {
        Task { @MainActor in
            guard !state.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                state.errorMessage = "Der Quest-Titel darf nicht leer sein"
                state.showError = true
                return
            }
            
            state.isSaving = true
            state.showError = false
            
            let newQuest = Quest(
                title: state.title,
                notes: state.notes,
                difficulty: state.difficulty,
                dueDate: state.dueDate,
                done: false
            )
            
            do {
                try await createQuestUseCase.execute(quest: newQuest)
            } catch let error as QuestError {
                state.errorMessage = "Domain Fehler: \(error)"
                state.showError = true
            } catch {
                state.errorMessage = "Unbekannter Fehler: \(error.localizedDescription)"
                state.showError = true
            }
            
            state.isSaving = false
        }
    }
}
