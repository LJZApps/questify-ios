//
//  QuestDataModel+Mapper.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

extension QuestDataModel {
    func toDomain() -> Quest {
        let difficulty = Difficulty(rawValue: self.difficultyRawValue) ?? .medium
        
        return Quest(
            id: self.id,
            title: self.title,
            notes: self.notes,
            difficulty: difficulty,
            dueDate: self.dueDate,
            done: self.done
        )
    }
}

extension Quest {
    func toDataModel() -> QuestDataModel {
        return QuestDataModel(
            id: self.id,
            title: self.title,
            notes: self.notes,
            difficultyRawValue: self.difficulty.rawValue,
            dueDate: self.dueDate,
            done: self.done
        )
    }
}
