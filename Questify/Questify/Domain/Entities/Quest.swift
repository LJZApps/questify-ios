//
//  Quest.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

struct Quest: Identifiable, Codable {
    let id: UUID
    
    var title: String
    var notes: String?
    var difficulty: Difficulty
    var dueDate: Date?
    var done: Bool
    
    var subQuests: [SubQuest] = []
    
    init(
        id: UUID = UUID(),
        title: String,
        notes: String? = nil,
        difficulty: Difficulty,
        dueDate: Date? = nil,
        done: Bool = false,
        subQuests: [SubQuest] = []
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.difficulty = difficulty
        self.dueDate = dueDate
        self.done = done
        self.subQuests = subQuests
    }
}
