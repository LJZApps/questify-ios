//
//  GetStartedMain.swift
//  Questify
//
//  Created by Leon Zapke on 24.10.24.
//

import SwiftUI
import SwiftData

struct GetStartedMainView: View {
    @StateObject private var viewModel = GetStartedViewModel()
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Platzhalter oben für zentrierte Ausrichtung

                // Haupttext zentriert in der Mitte des Bildschirms
                Text("Ready to make each day your own personal quest?")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16) // Horizontaler Padding
                    .frame(maxWidth: .infinity) // Volle Breite, um zentriert zu sein
                    .font(Font.custom("PressStart2P-Regular", size: 16))
                    .lineSpacing(10)
                
                Spacer() // Platzhalter unten für zentrierte Ausrichtung

                // Direkter NavigationLink für die Navigation zum HomeView
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) { // Versteckt den Zurück-Button in HomeView
                    Text("Yes, let's start!")
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("PressStart2P-Regular", size: 10))
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.setSetupDone() // Setup-Status setzen, bevor Navigation stattfindet
                })
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal, 10) // Horizontaler Padding für den Button
                .padding(.bottom, 2) // Abstand vom unteren Rand des Bildschirms
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Volle Bildschirmgröße
        }
    }
}

// Vorschau für GetStartedMainView
struct GetStartedMainView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedMainView()
    }
}
