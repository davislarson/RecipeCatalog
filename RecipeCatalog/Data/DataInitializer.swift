//
//  DataInitializer.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import Foundation
import SwiftData

struct DataInitializer {
    
    // Option 1: Simple check - initialize if no recipes exist
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
