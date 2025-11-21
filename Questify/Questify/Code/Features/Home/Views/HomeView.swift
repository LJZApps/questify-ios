import SwiftUI

enum AppScreen: Hashable {
    case yourQuests
    case settings
}

struct HomeScene: Scene {
    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                List {
                    Section(header: Text("Missions")) {
                        NavigationLink(value: AppScreen.yourQuests) {
                            Label("Quests", systemImage: "checkmark.circle")
                        }
                    }
                }
                .frame(minWidth: 200)
                .listStyle(.sidebar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            path.append(AppScreen.settings)
                        }) {
                            Image(systemName: "gear")
                        }
                    }
                }
                .navigationTitle("Questify")
                .navigationDestination(for: AppScreen.self) { destination in
                    switch destination {
                        case .yourQuests:
                            YourQuestsView()
                        case .settings:
                            Text("Hier kommen die Einstellungen")
                    }
                }
            }
        }
    }
}

enum DifficultyUI: String, CaseIterable {
    case easy = "Leicht"
    case medium = "Mittel"
    case hard = "Schwer"
    
    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .easy: return "tortoise.fill"
        case .medium: return "figure.walk"
        case .hard: return "flame.fill"
        }
    }
}

struct YourQuestsView: View {
    @State private var showingCreateQuestSheet = false
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                      .font(.largeTitle)
                      .foregroundColor(.primary)
                      .padding([.bottom], 8)
                
                Text("You haven't created any quests yet.")
                    .padding([.bottom], 8)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    showingCreateQuestSheet.toggle()
                }, label: {
                    Text("Create a Quest now")
                })
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle("Quests")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button(action: {  }) {
                        Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingCreateQuestSheet) {
            CreateQuestView()
        }
    }
}

struct CreateQuestView: View {
    @Environment(\.dismiss) var dismiss
    
    // UI State
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var dateText: String = "12. Okt 2025"
    @State private var timeText: String = "14:00"
    @State private var selectedDifficulty: DifficultyUI = .easy
    
    @State private var subtasks: [String] = ["Erste Unteraufgabe", "Zweite Unteraufgabe"]
    @State private var reminders: [String] = ["12. Okt 2025 13:00"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Hier rufen wir jetzt nur noch die kleinen Stücke auf
                    Form {
                        TextField("Gib den Titel deiner Quest ein...", text: $title)
                        
                        TextField("Füge hier detaillierte Notizen hinzu...", text: $notes, axis: .vertical)
                            .lineLimit(3...5)
                    }
                    dateTimeSection
                    remindersSection
                    difficultySection
                    subtasksSection
                }
                .padding()
                .padding(.bottom, 80)
            }
            .navigationTitle("Quest erstellen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: {}) {
                            Label("Kategorie: Liste", systemImage: "tag.fill")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                createButton
            }
        }
    }
}

// MARK: - Subviews (Das löst das Compiler-Problem)
extension CreateQuestView {
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Titel")
                .font(.headline)
        }
    }
    
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notizen")
                .font(.headline)
            
            TextField("Füge hier detaillierte Notizen hinzu...", text: $notes, axis: .vertical)
                .lineLimit(3...5)
        }
    }
    
    private var dateTimeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Fälligkeitsdatum & Zeit")
                .font(.headline)
            
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(dateText.isEmpty ? "Datum" : dateText)
                    Spacer()
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text(timeText.isEmpty ? "Zeit" : timeText)
                    Spacer()
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                .frame(maxWidth: 120)
            }
        }
    }
    
    private var remindersSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Erinnerungen")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(reminders, id: \.self) { reminder in
                        HStack {
                            Image(systemName: "bell.fill")
                                .font(.caption)
                            Text(reminder)
                                .font(.subheadline)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
            
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                    Text("Erinnerung hinzufügen")
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
            }
        }
    }
    
    private var difficultySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Schwierigkeit")
                .font(.headline)
            
            HStack(spacing: 0) {
                ForEach(DifficultyUI.allCases, id: \.self) { difficulty in
                    Button(action: { selectedDifficulty = difficulty }) {
                        VStack(spacing: 4) {
                            Image(systemName: difficulty.icon)
                            Text(difficulty.rawValue)
                                .font(.caption)
                        }
                        .foregroundColor(selectedDifficulty == difficulty ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(selectedDifficulty == difficulty ? Color.accentColor : Color.clear)
                    }
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                    )
                }
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
    
    private var subtasksSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Unteraufgaben")
                .font(.headline)
            
            ForEach(0..<subtasks.count, id: \.self) { index in
                HStack {
                    TextField("Text hier eingeben", text: $subtasks[index])
                    
                    Button(action: {}) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
            
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                    Text("Unteraufgabe hinzufügen")
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
            }
        }
    }
    
    private var createButton: some View {
        VStack(spacing: 0) {
            Divider()
            Button(action: {}) {
                Text("Quest erstellen")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(title.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}
