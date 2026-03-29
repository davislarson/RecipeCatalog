//
//  ViewModel.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import SwiftUI
import SwiftData
import Foundation

@Observable
final class ViewModel: ContextReferencing {
    
    
    // MARK: - Properties
    private var modelContext: ModelContext
        
    var categories: [Category] = []
    
    var recipes: [Recipe] = []
    
    
    // MARK: - Navigation properties
    
    var selectedFilter: RecipeFilter? = .all
    var selectedRecipe: Recipe? = nil
    var columnVisibility: NavigationSplitViewVisibility = .all
    
    var sideBarTitle = "Recipe Catalog"

    // MARK: - Timer Properties

    var isTimerRunning = false
    var remainingSeconds = 0
    var activeTimerName: String?
    var completedTimerName: String?
    var showTimerFinishedAlert = false

    @ObservationIgnored
    private var timer: Timer?
    
    var contentListTitle: String {
        guard let filter = selectedFilter else {
            return "Select A Category"
        }
        
        switch filter {
        case .all:
            return "All Recipes"
        case .category(let name):
            return name
        case .favorites:
            return "Favorites"
        case .search(let term):
            return "Search: \(term)"
        }
    }
    
    // MARK: Initialization
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchCategories()
    }
    
    // MARK: - Data retrieval
    
    func fetchRecipes(for filter: RecipeFilter = .all) {
        let descriptor: FetchDescriptor<Recipe>
        
        switch filter {
        case .all:
            descriptor = FetchDescriptor<Recipe>(
                sortBy: [SortDescriptor(\.title)]
            )
        case .category(let categoryName):
            descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate<Recipe> { recipe in
                    recipe.categories.contains(where: { $0.name == categoryName })
                },
                sortBy: [SortDescriptor(\.title)]
            )
            
        case .favorites:
            descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate<Recipe> { recipe in
                    recipe.isFavorite == true
                },
                sortBy: [SortDescriptor(\.title)]
            )
            
        case .search(_):
            // Get everything and filter after.
            // NOTE: I made this change after a getting super far into the project. #predicate can only use stored values not computed vars. Therefore in order to keep the application similar and not totally refactor things, update in this way by filtering after searching for all recipes.
            descriptor = FetchDescriptor<Recipe>(
                sortBy: [SortDescriptor(\.title)]
            )
        }
        
        do {
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching recipes: \(error)")
            recipes = []
        }
        
        if case .search(let searchTerm) = filter {
            let lowercasedTerm = searchTerm.lowercased()
            recipes = recipes.filter { recipe in
                recipe.searchString.localizedStandardContains(lowercasedTerm)
            }
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
  
    // MARK: - Recipe User Intents
    
    func addRecipe(title: String,
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
        let recipe = Recipe(
            title: title,
            creator: creator,
            dateCreated: dateCreated,
            prepTime: prepTime,
            serves: serves,
            difficulty: difficulty,
            caloriesPerServing: caloriesPerServing,
            isFavorite: isFavorite,
            notes: notes,
            categories: categories,
            ingredients: ingredients,
            instructions: instructions
        )
        modelContext.insert(recipe)
        saveChanges()
        selectedFilter = .all
        fetchRecipes()
    }
    
    func deleteRecipes(offsets: IndexSet) {
        for index in offsets {
            let recipe = recipes[index]
            modelContext.delete(recipe)
        }
        saveChanges()
        
        if let filter = selectedFilter {
            fetchRecipes(for: filter)
        }
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
        
        // Update categories - handle the many-to-many relationship
        let currentCategories = Set(recipe.categories)
        let newCategories = Set(categories)
        
        // Remove categories that were deselected
        let categoriesToRemove = currentCategories.subtracting(newCategories)
        for category in categoriesToRemove {
            recipe.removeCategory(category)
        }
        
        // Add newly selected categories
        let categoriesToAdd = newCategories.subtracting(currentCategories)
        for category in categoriesToAdd {
            recipe.addCategory(category)
        }
        
        // Handle ingredients - delete old ones and add new ones
        for ingredient in recipe.ingredients {
            modelContext.delete(ingredient)
        }
        recipe.ingredients.removeAll()
        
        for ingredientData in ingredients {
            let newIngredient = Ingredient(
                order: ingredientData.order,
                quantity: ingredientData.quantity,
                unit: ingredientData.unit,
                name: ingredientData.name,
                notes: ingredientData.notes,
                recipe: recipe
            )
            recipe.addIngredient(newIngredient)
            modelContext.insert(newIngredient)
        }
        
        // Handle instructions - delete old ones and add new ones
        for instruction in recipe.instructions {
            modelContext.delete(instruction)
        }
        recipe.instructions.removeAll()
        
        for instructionData in instructions {
            let newInstruction = Instruction(
                order: instructionData.order,
                text: instructionData.text,
                recipe: recipe
            )
            recipe.addInstruction(newInstruction)
            modelContext.insert(newInstruction)
        }
        
        saveChanges()
    }
    
    func removeRecipeFromCategory(_ recipe: Recipe, categoryName: String) {
        guard let category = categories.first(where: { $0.name == categoryName }) else {
            return
        }
        
        // Use the model method
        recipe.removeCategory(category)
        
        saveChanges()
        
        if let filter = selectedFilter {
            fetchRecipes(for: filter)
        }
    }
    
    func addCategoryToRecipe(_ category: Category, recipe: Recipe) {
        // Use the model method
        recipe.addCategory(category)
        saveChanges()
    }

    func removeCategoryFromRecipe(_ category: Category, recipe: Recipe) {
        // Use the model method
        recipe.removeCategory(category)
        saveChanges()
    }
    
    // MARK: - Category User Intents
    
    func createCategory(name: String, recipes: [Recipe] = []) {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        let newCategory = Category(name: trimmedName, recipes: [])
        modelContext.insert(newCategory)
        
        // Add selected recipes to the new category using model methods
        for recipe in recipes {
            newCategory.addRecipe(recipe)
        }
        
        saveChanges()
        fetchCategories()
    }

    func updateCategory(_ category: Category, name: String, recipes: [Recipe]) {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        // Update category name
        category.name = trimmedName
        
        // Update recipe associations using model methods
        let currentRecipes = Set(category.recipes)
        let newRecipes = Set(recipes)
        
        // Remove recipes that were deselected
        let recipesToRemove = currentRecipes.subtracting(newRecipes)
        for recipe in recipesToRemove {
            category.removeRecipe(recipe)
        }
        
        // Add newly selected recipes
        let recipesToAdd = newRecipes.subtracting(currentRecipes)
        for recipe in recipesToAdd {
            category.addRecipe(recipe)
        }
        
        saveChanges()
        fetchCategories()
        
        // Refresh the recipe list if viewing that category
        if case .category(let categoryName) = selectedFilter, categoryName == category.name {
            fetchRecipes(for: selectedFilter ?? .all)
        }
    }
    
    func deleteCategories(offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            modelContext.delete(category)
        }
        saveChanges()
        fetchCategories()
    }
    
    // MARK: - Helper Methods
    
    func getAvailableCategories(excluding selected: [Category]) -> [Category] {
        allCategories.filter { category in
            !selected.contains(where: { $0.name == category.name })
        }
    }
    
    func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    // MARK: - Timer Intents

    var remainingTimeDisplay: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }

        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer(minutes: Int, name: String?) {
        let safeMinutes = max(1, minutes)
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)

        timer?.invalidate()
        timer = nil

        remainingSeconds = safeMinutes * 60
        activeTimerName = (trimmedName?.isEmpty == false) ? trimmedName : nil
        completedTimerName = nil
        showTimerFinishedAlert = false
        isTimerRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.handleTimerTick()
        }
    }

    func clearFinishedTimerAlert() {
        showTimerFinishedAlert = false
        completedTimerName = nil
    }

    private func handleTimerTick() {
        guard isTimerRunning else {
            timer?.invalidate()
            timer = nil
            return
        }

        if remainingSeconds > 0 {
            remainingSeconds -= 1
        }

        if remainingSeconds <= 0 {
            finishTimer()
        }
    }

    private func finishTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        completedTimerName = activeTimerName
        activeTimerName = nil
        remainingSeconds = 0
        showTimerFinishedAlert = true
    }
    
    // MARK: - Context referencing
    func update() {
        fetchCategories()
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: - Recipe Filter Enum

enum RecipeFilter: Equatable, Hashable {
    case all
    case category(String)
    case favorites
    case search(String)
}
