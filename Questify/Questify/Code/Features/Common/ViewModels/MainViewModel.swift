//
//  MainViewModel.swift
//  Questify
//
//  Created by Leon Zapke on 24.10.24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var isSetupDone: Bool = false
    
    init() {
        isSetupDone = UserDefaults.standard.bool(forKey:"isSetupDone")
    }
    
    func setSetupDone() {
        UserDefaults.standard.set(true, forKey: "isSetupDone")
        isSetupDone = true
    }
}
