//
//  Trip.swift
//  Questify
//
//  Created by Leon Zapke on 24.10.24.
//

import SwiftData
import Foundation

@Model
class Trip {
    var name: String
    var destination: String
    var startDate: Date
    var endDate: Date
    
    init(name: String, destination: String, startDate: Date, endDate: Date) {
        self.name = name
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
    }
}
