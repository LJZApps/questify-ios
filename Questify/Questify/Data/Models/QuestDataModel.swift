//
//  QuestDataModel.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation
import SwiftData

@Model
final class QuestDataModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var notes: String?
    var difficultyRawValue: String
    var dueDate: Date?
    var done: Bool
    
    init(id: UUID, title: String, notes: String? = nil, difficultyRawValue: String, dueDate: Date? = nil, done: Bool) {
        self.id = id
        self.title = title
        self.notes = notes
        self.difficultyRawValue = difficultyRawValue
        self.dueDate = dueDate
        self.done = done
    }
}
