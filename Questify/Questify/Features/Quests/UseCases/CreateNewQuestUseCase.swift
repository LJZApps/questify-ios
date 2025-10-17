//
//  CreateNewQuestUseCase.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

protocol CreateNewQuestUseCaseProtocol {
    func execute(quest: Quest) async throws
}

final class CreateNewQuestUseCase: CreateNewQuestUseCaseProtocol {
    private let questRepository: QuestRepositoryProtocol
    
    init(questRepository: QuestRepositoryProtocol) {
        self.questRepository = questRepository
    }
    
    func execute(quest: Quest) async throws {
        if quest.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw QuestError.invalidTitle
        }
        
        try await questRepository.save(quest: quest)
    }
}
