//
//  GetStartedViewModel.swift
//  Questify
//
//  Created by Leon Zapke on 24.10.24.
//

import Foundation
import SwiftData

class GetStartedViewModel: ObservableObject {
    @Published var isSetupDone: Bool = false
    //private var container: ModelContainer
    
    func setSetupDone() {
        UserDefaults.standard.set(true, forKey: "isSetupDone")
        isSetupDone = true
    }
    
    func checkIfSetupIsDone() {
        isSetupDone = UserDefaults.standard.bool(forKey: "isSetupDone")
    }
}
