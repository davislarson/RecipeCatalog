//
//  RecipeCatalogApp.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import SwiftUI
import SwiftData // Allows ModelContainer to be found


// In conjunciton with getting the data into the app there were some additions to this file suggested by claude:
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
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // Initialize sample data if needed
            let context = ModelContext(container)
            let descriptor = FetchDescriptor<Recipe>()
            
            if let existingRecipes = try? context.fetch(descriptor), existingRecipes.isEmpty {
                print("No recipes found. Initializing with sample data...")
                Category.insertSampleData(modelContext: context)
                try? context.save()
            } else {
                print("Found existing recipes. Skipping initialization.")
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
