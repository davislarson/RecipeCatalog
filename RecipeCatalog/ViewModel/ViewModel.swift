//
//  ViewModel.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import SwiftUI
import SwiftData

@Observable
final class ViewModel: ContextReferencing {
    
    
    // MARK: - Properties
    private var modelContext: ModelContext
        
    var categories: [Category] = []
    
    var recipes: [Recipe] = []
    
    
    // MARK: - Navigation properties
    
    var selectedCategoryName: String? = nil
    var selectedRecipe: Recipe? = nil
    var columnVisibility: NavigationSplitViewVisibility = .all
    
    var sideBarTitle = "Categories"
    
    var contentListTitle: String {
       selectedCategoryName ?? "Recipes"
    }
    
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
            recipes = (try modelContext.fetch(descriptor))
        } catch {
            print("Error fetching recipes: \(error)")
            recipes = []
        }
        
    }
    
    func fetchCategories() {
        let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\.name)])
        do {
            categories = (try modelContext.fetch(descriptor))
        } catch {
            print("Error fetching categories: \(error)")
            categories = []
        }
    }
    
    
    // MARK: - Model Access
    
    var allCategories: [Category] {
        let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\.name)])
        
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    var allRecipes: [Recipe]  {
        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
        
        return (try? modelContext.fetch(descriptor)) ?? []
    }
  
    // MARK: - User Intents
    
    func addRecipe() {
        
    }
    
    func deleteRecipes(offsets: IndexSet) {
        
    }
    
    func addCategory() {
        let newCategory = Category(name: "New Category", recipes: [])
            modelContext.insert(newCategory)
            saveChanges()
            fetchCategories()
        }
        
    func deleteCategories(offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            // Remove category from all recipes
            for recipe in category.recipes {
                recipe.categories.removeAll(where: { $0.name == category.name })
            }
            modelContext.delete(category)
        }
        saveChanges()
        fetchCategories()
    }
    
    func deleteAllIngredients(from recipe: Recipe) {
        recipe.ingredients.forEach { ingredient in
            modelContext.delete(ingredient)
        }
        recipe.ingredients.removeAll()
    }
    
    func deleteIngredient(_ ingredient: Ingredient) {
        modelContext.delete(ingredient)
    }
    
    func insertIngredient(_ ingredient: Ingredient) {
        modelContext.insert(ingredient)
    }
    
    func deleteAllInstructions(from recipe: Recipe) {
        recipe.instructions.forEach { instruction in
            modelContext.delete(instruction)
        }
        recipe.instructions.removeAll()
    }

    func deleteInstruction(_ instruction: Instruction) {
        modelContext.delete(instruction)
    }
    
    func insertInstruction(_ instruction: Instruction) {
        modelContext.insert(instruction)
    }
    
    func saveChanges() {
        try? modelContext.save()
    }

    func updateRecipe(
        _ recipe: Recipe,
        title: String,
        creator: String,
        dateCreated: Date,
        prepTime: Int,
        serves: Int,
        difficulty: DifficultyLevel,
        caloriesPerServing: Int?,
        isFavorite: Bool,
        notes: String?,
        categories: [Category],
        ingredients: [Ingredient],
        instructions: [Instruction]
    ) {
        // Update basic properties
        recipe.title = title
        recipe.creator = creator
        recipe.dateCreated = dateCreated
        recipe.prepTime = prepTime
        recipe.serves = serves
        recipe.difficulty = difficulty
        recipe.caloriesPerServing = caloriesPerServing
        recipe.isFavorite = isFavorite
        recipe.notes = notes
        recipe.categories = categories
        
        // Handle ingredients
        deleteAllIngredients(from: recipe)
        for ingredientData in ingredients {
            let newIngredient = Ingredient(
                order: ingredientData.order,
                quantity: ingredientData.quantity,
                unit: ingredientData.unit,
                name: ingredientData.name,
                notes: ingredientData.notes,
                recipe: recipe
            )
            recipe.ingredients.append(newIngredient)
            insertIngredient(newIngredient)
        }
        
        // Handle instructions
        deleteAllInstructions(from: recipe)
        for instructionData in instructions {
            let newInstruction = Instruction(
                order: instructionData.order,
                text: instructionData.text,
                recipe: recipe
            )
            recipe.instructions.append(newInstruction)
            insertInstruction(newInstruction)
        }
        
        saveChanges()
    }

    func addCategoryToRecipe(_ category: Category, recipe: Recipe) {
        if !recipe.categories.contains(where: { $0.name == category.name }) {
            recipe.categories.append(category)
            saveChanges()
        }
    }

    func removeCategoryFromRecipe(_ category: Category, recipe: Recipe) {
        recipe.categories.removeAll { $0.name == category.name }
        saveChanges()
    }

    func getAvailableCategories(excluding selected: [Category]) -> [Category] {
        allCategories.filter { category in
            !selected.contains(where: { $0.name == category.name })
        }
    }
    
    
    // MARK: - Context referencing
    func update() {
        fetchCategories()
    }
    
}
