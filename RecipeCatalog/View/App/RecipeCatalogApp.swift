//
//  RecipeCatalogApp.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import SwiftUI
import SwiftData // Allows ModelContainer to be found


// In conjunciton with DataInitializer there were some additions to this file suggested by claude:
// https://claude.ai/share/69dca26e-dbb1-48b7-a053-08f1284e8acf

@main
struct RecipeCatalogApp: App {
    var sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Recipe.self,
                Category.self,
                Ingredient.self,
                Instruction.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    let context = ModelContext(sharedModelContainer)
                    DataInitializer.initializeIfNeeded(context: context)
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
