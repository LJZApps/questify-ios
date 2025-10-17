//
//  QuestRepositoryProtocol.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

protocol QuestRepositoryProtocol {
    func fetchAllQuests() async throws -> [Quest]
    func fetchQuest(id: UUID) async throws -> Quest?
    
    func save(quest: Quest) async throws
    func update(quest: Quest) async throws
    
    func delete(id: UUID) async throws
}
