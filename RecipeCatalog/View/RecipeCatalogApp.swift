//
//  RecipeCatalogApp.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import SwiftUI
import SwiftData

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
