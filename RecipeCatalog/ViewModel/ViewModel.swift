//
//  ViewModel.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import SwiftUI
import SwiftData

@Observable
class ViewModel: ContextReferencing {
    
    // MARK: - Properties
    private let modelContext: ModelContext
    var recipes: [Recipe] = []
    var categories: [Category] = []
    
    // MARK: Initialization
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchCategories()
    }
    
    // MARK: - Data retrieval
    
    // This gives the UI the data that is already initialized from the presets
    
    func fetchRecipes(for categoryName: String? = nil) {
        var descriptor: FetchDescriptor<Recipe>
        
        if let categoryName = categoryName {
            print(categoryName)
            descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate<Recipe> { recipe in
                    recipe.categories.contains(where: { $0.name == categoryName }) 
                },
                sortBy: [SortDescriptor(\.title)])
        } else {
            // This will fetch all recipes if no category is set
            descriptor = FetchDescriptor<Recipe> (
                predicate: #Predicate<Recipe> { _ in true },
                sortBy: [SortDescriptor(\.title)]
            )
        }
        
        do {
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching recipes: \(error)")
            recipes = []
        }
        
    }
    
    func fetchCategories() {
        let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\.name)])
        do {
            categories = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching categories: \(error)")
            categories = []
        }
    }
    
    
    // MARK: - Model Access
    
    
    // MARK: - User Intents
    
    func addRecipe() {
        
    }
    
    func deleteRecipes(offsets: IndexSet) {
        
    }
    
    func saveChanges() {
        try? modelContext.save()
    }
    
    // MARK: - Context referencing
    func update() {
        fetchCategories()
    }
    
}
