import SwiftUI

enum ViewSelection: Hashable {
    case dashboard, yourQuests
}

struct HomeView: View {
    @State private var selection: ViewSelection? = nil // Beginnt als nil
    @State private var hasAppeared = false // Überprüft, ob die Ansicht zum ersten Mal geladen wird

    var body: some View {
        NavigationStack {
            List {
                NavigationLink(tag: ViewSelection.dashboard, selection: $selection) {
                    DashboardView()
                } label: {
                    Label("Dashboard", systemImage: "house")
                }
                
                Section(header: Text("Quests")) {
                    NavigationLink(tag: ViewSelection.yourQuests, selection: $selection) {
                        YourQuestsView()
                    } label: {
                        Label("Your Quests", systemImage: "list.bullet")
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
            .onAppear {
                if !hasAppeared {
                    selection = .dashboard // Setzt Dashboard als Startansicht beim ersten Erscheinen
                    hasAppeared = true // Setzt den Status auf wahr, um erneutes Setzen zu verhindern
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
    var body: some View {
        VStack {
            TabView {
                Text("Quests")
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Quests")
                    }
                
                Text("Dailies")
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Dailies")
                    }
                
                Text("Routines")
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Routines")
                    }
                
                Text("Rituals")
                    .tabItem {
                        Image(systemName: "leaf")
                        Text("Rituals")
                    }
            }
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
