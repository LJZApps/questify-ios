import SwiftUI

enum ViewSelection: Hashable {
    case dashboard, yourQuests, settings
}

struct HomeView: View {
    @State private var selection: ViewSelection? = nil
    @State private var hasAppeared = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Missionen")) {
                    NavigationLink(tag: ViewSelection.yourQuests, selection: $selection) {
                        YourQuestsView()
                    } label: {
                        Label("Quests", systemImage: "list.bullet")
                    }
                    
                    NavigationLink(tag: ViewSelection.yourQuests, selection: $selection) {
                        YourQuestsView()
                    } label: {
                        Label("Gewohnheiten", systemImage: "leaf")
                    }
                }
                
                Section(header: Text("Erfolge")) {
                    NavigationLink(tag: ViewSelection.yourQuests, selection: $selection) {
                        YourQuestsView()
                    } label: {
                        Label("Werte", systemImage: "chart.bar.xaxis")
                    }
                }
            }
            .navigationTitle("Questify")
            .toolbar {
                ToolbarItem {
                    Button(action: {}) {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

struct DashboardView: View {
    var body: some View {
        Text("Hier kommt das Dashboard")
            .navigationTitle("Dashbaord")
    }
}

struct YourQuestsView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            List {
                
            }
            .searchable(text: $searchText, prompt: "Quests suchen")
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text("Your Quests")
                            .font(.headline)
                    }
                ToolbarItem {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
