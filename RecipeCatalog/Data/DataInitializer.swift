//
//  DataInitializer.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import Foundation
import SwiftData


// Asking claude how to set up the initial data gave me this file
// Here is the chat link: https://claude.ai/share/69dca26e-dbb1-48b7-a053-08f1284e8acf
struct DataInitializer {
    
    // Simple check - initialize if no recipes exist
    static func initializeIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<Recipe>()
        
        do {
            let existingRecipes = try context.fetch(descriptor)
            
            if existingRecipes.isEmpty {
                print("No recipes found. Initializing with preset recipes...")
                PresetRecipes.createDefaultRecipes(context: context)
            } else {
                print("Found \(existingRecipes.count) existing recipes. Skipping initialization.")
            }
        } catch {
            print("Error checking for existing recipes: \(error)")
        }
    }
}
