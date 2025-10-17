//
//  SubQuest.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import Foundation

struct SubQuest: Identifiable, Codable {
    let id: UUID
    
    var title: String
    var done: Bool
    
    init(id: UUID = UUID(), title: String, done: Bool = false) {
        self.id = id
        self.title = title
        self.done = done
    }
}
