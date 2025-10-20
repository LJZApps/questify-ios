//
//  QuestFeatureFactory.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import SwiftUI

protocol QuestFeatureFactoryProtocol {
    func makeCreateQuestScreen() -> CreateQuestScreen
}

final class QuestFeatureFactory: QuestFeatureFactoryProtocol {
    private let createQuestUseCase: CreateNewQuestUseCaseProtocol
    
    init(createQuestUseCase: CreateNewQuestUseCaseProtocol) {
        self.createQuestUseCase = createQuestUseCase
    }
    
    func makeCreateQuestScreen() -> CreateQuestScreen {
        let viewModel = CreateQuestViewModel(createQuestUseCase: createQuestUseCase)
        
        return CreateQuestScreen(viewModel: viewModel)
    }
}

// MARK: - Environment Key für die Factory


private struct QuestFeatureFactoryKey: EnvironmentKey {
    static let defaultValue: QuestFeatureFactoryProtocol = MockQuestFeatureFactory()
}

extension EnvironmentValues {
    var questFeatureFactory: QuestFeatureFactoryProtocol {
        get { self[QuestFeatureFactoryKey.self] }
        set { self[QuestFeatureFactoryKey.self] = newValue }
    }
}

private final class MockQuestFeatureFactory: QuestFeatureFactoryProtocol {
    func makeCreateQuestScreen() -> CreateQuestScreen {
        let mockUseCase = MockCreateNewQuestUseCase()
        let mockViewModel = CreateQuestViewModel(createQuestUseCase: mockUseCase)
        return CreateQuestScreen(viewModel: mockViewModel)
    }
}

private struct MockCreateNewQuestUseCase: CreateNewQuestUseCaseProtocol {
    func execute(quest: Quest) async throws {
        print("MOCK: Quest '\(quest.title)' saved.")
    }
}
