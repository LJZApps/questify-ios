//
//  CreateQuestUiState.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

struct CreateQuestUiState {
    var title: String = ""
    var notes: String = ""
    var difficulty: Difficulty = .easy
    var dueDate: Date = Date().addingTimeInterval(24 * 60 * 60)
    
    var isSaving: Bool = false
    var showError: Bool = false
    var errorMessage: String = ""
}
