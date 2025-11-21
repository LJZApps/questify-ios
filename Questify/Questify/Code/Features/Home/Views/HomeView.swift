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
                    Section(header: Text("Missions")) {
                        NavigationLink(value: AppScreen.yourQuests) {
                            Label("Quests", systemImage: "checkmark.circle")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Habits", systemImage: "leaf")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Routines", systemImage: "repeat")
                        }
                    }
                    
                    Section(header: Text("Achievements")) {
                        NavigationLink(value: AppScreen.settings) {
                            Label("Stats", systemImage: "chart.bar")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Leaderboard", systemImage: "trophy")
                        }
                    }
                    
                    Section(header: Text("Social")) {
                        NavigationLink(value: AppScreen.settings) {
                            Label("Friends", systemImage: "person.3")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Guilds", systemImage: "shield")
                        }
                    }
                    
                    Section(header: Text("Village of Ventures")) {
                        NavigationLink(value: AppScreen.settings) {
                            Label("Map", systemImage: "map")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Buildings", systemImage: "house")
                        }
                        
                        NavigationLink(value: AppScreen.settings) {
                            Label("Shop", systemImage: "cart")
                        }
                    }
                }
                .frame(minWidth: 200)
                .listStyle(.sidebar)
                .toolbar {
                    ToolbarItem {
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                    }
                }
                .navigationTitle("Questify")
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
                }
            }
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
        VStack {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                      .font(.largeTitle)
                      .foregroundColor(.primary)
                      .padding([.bottom], 8)
                
                Text("You haven't created any quests yet.")
                    .padding([.bottom], 8)
                    .multilineTextAlignment(.center)
                
                Button(action: {}, label: {
                    Text("Create a Quest now")
                })
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        //.listStyle(.insetGrouped)
        .navigationTitle("Quests")
        .toolbar {
            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem {
                Menu {
                    // Hier kommen deine Aktionen rein
                    Button(action: {  }) {
                        Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    }
                } label: {
                    // Der Auslöser (dein Icon)
                    Image(systemName: "ellipsis.circle") // .circle ist oft besser klickbar als nur die Punkte
                }
            }
        }
    }
}
