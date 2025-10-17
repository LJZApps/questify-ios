//
//  CreateQuestScreen.swift
//  Questify
//
//  Created by Leon Zapke on 17.10.25.
//

import SwiftUI
import Observation

struct CreateQuestScreen: View {
    @Bindable var viewModel: CreateQuestViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Quest-Detail
                Section("Titel & Notizen") {
                    TextField("Titel der Quest", text: $viewModel.state.title)
                    
                    TextEditor(text: $viewModel.state.notes)
                        .frame(minHeight: 100)
                        .scrollContentBackground(.hidden)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Section("Schwierigkeit") {
                    Picker("Wähle die Schwierigkeit", selection: $viewModel.state.difficulty) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                        }
                    }.pickerStyle(.menu)
                }
                
                Section("Fälligkeitsdatum") {
                    DatePicker("Wann ist es fällig?", selection: $viewModel.state.dueDate)
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.saveQuest()
                    }) {
                        if viewModel.state.isSaving {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else {
                            Text("Quest speichern")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.state.isSaving || viewModel.state.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Neue Quest")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
            .alert("Fehler", isPresented: $viewModel.state.showError) {
                Button("Verstanden", role: .cancel) {}
            } message: {
                Text(viewModel.state.errorMessage)
            }
            .onChange(of: viewModel.state.isSaving) { oldValue, newValue in
                if oldValue == true && newValue == false && !viewModel.state.showError {
                    dismiss()
                }
            }
        }
    }
}
