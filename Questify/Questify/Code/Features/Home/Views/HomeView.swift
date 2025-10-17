import SwiftUI

enum AppScreen: Hashable {
    case yourQuests
    case settings
}

struct HomeScene: Scene {
    @State private var selection: AppScreen? = .yourQuests
    
    @State private var detailPath = NavigationPath()
    
    @State private var searchText = ""

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                List(selection: $selection) {
                    Section(header: Text("Missionen")) {
                        NavigationLink(value: AppScreen.yourQuests) {
                            Label("Quests", systemImage: "list.bullet")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Gewohnheiten", systemImage: "leaf")
                        }
                    }
                    
                    Section(header: Text("Erfolge")) {
                        NavigationLink(value: AppScreen.settings) {
                            Label("Werte", systemImage: "chart.bar.xaxis")
                        }
                    }
                }
                .frame(minWidth: 200)
                .listStyle(.sidebar)
                .tint(.secondary)
            } detail: {
                NavigationStack(path: $detailPath) {
                    Group {
                        switch selection {
                        case .yourQuests:
                            YourQuestsView()
                        case .settings:
                            Text("Hier kommen die Einstellungen")
                        case .none:
                            Text("Wähle deine Mission aus der Sidebar.")
                        }
                    }
                    .toolbar {
                        ToolbarItem {
                            Button(action: {}) {
                                Image(systemName: "gear")
                            }
                        }
                    }
                }
            }
            .navigationSplitViewStyle(.automatic)
            .searchable(text: $searchText, placement: .toolbar, prompt: "Quests suchen")
            
            .onAppear {
                if selection == nil {
                    selection = .yourQuests
                }
            }
        }
        }
}

struct YourQuestsView: View {
    var body: some View {
        List {
            Text("Noch keine Quests erstellt. Zeit, deine erste Mission zu erstellen!")
                .foregroundColor(.secondary)
        }
        //.listStyle(.insetGrouped)
        .navigationTitle("Your Quests")
        .toolbar {
            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
