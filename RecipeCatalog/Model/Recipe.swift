//
//  Item.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var creator: String
    var dateCreated: Date
    var prepTime: Int
    var serves: Int
    var difficulty: DifficultyLevel
    var caloriesPerServing: Int?
    var isFavorite: Bool
    var notes: String?
    
    // This is a many-to-many relationship
    @Relationship(deleteRule: .nullify) // This is the default functionality but can be explicit.
    var categories: [Category]
    
    // Recipe to ingredient is one to many. When deleting a recipe all ingredients are deleted.
    // An ingredient can only have one recipe.
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.recipe)
    var ingredients: [Ingredient]
    
    // Recipe to instruction is one to many. When deleting a recipe all instructions are deleted.
    // An instructions can only belong to one recipe.
    @Relationship(deleteRule: .cascade, inverse: \Instruction.recipe)
    var instructions: [Instruction]
    
    
    init(title: String, creator: String, dateCreated: Date, prepTime: Int, serves: Int, difficulty: DifficultyLevel, caloriesPerServing: Int? = nil, isFavorite: Bool, notes: String? = nil, categories: [Category], ingredients: [Ingredient], instructions: [Instruction]) {
        self.title = title
        self.creator = creator
        self.dateCreated = dateCreated
        self.prepTime = prepTime
        self.serves = serves
        self.difficulty = difficulty
        self.caloriesPerServing = caloriesPerServing
        self.isFavorite = isFavorite
        self.notes = notes
        self.categories = categories
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    
    // MARK: - Helper Methods
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    func addCategory(_ category: Category) {
        if !categories.contains(where: { $0.name == category.name }) {
            categories.append(category)
        }
    }
    
    func removeCategory(_ category: Category) {
        categories.removeAll(where: { $0.name == category.name })
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredient.recipe = self  // Set the relationship
        ingredients.append(ingredient)
    }

    func removeIngredient(_ ingredient: Ingredient) {
        ingredients.removeAll(where: { $0.order == ingredient.order })
    }

    func updateIngredient(at index: Int, order: Int, quantity: String, unit: String, name: String, notes: String?) {
        guard ingredients.indices.contains(index) else { return }
        let ingredient = ingredients[index]
        ingredient.order = order
        ingredient.quantity = quantity
        ingredient.unit = unit
        ingredient.name = name
        ingredient.notes = notes
    }
    
    func addInstruction(_ instruction: Instruction) {
        instruction.recipe = self
        instructions.append(instruction)
    }

    func removeInstruction(_ instruction: Instruction) {
        instructions.removeAll(where: { $0.order == instruction.order })
    }

    func updateInstruction(at index: Int, order: Int, text: String) {
        guard instructions.indices.contains(index) else { return }
        let instruction = instructions[index]
        instruction.order = order
        instruction.text = text
    }
}

enum DifficultyLevel: String, Codable, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"
}

extension Recipe {
    var searchString: String {
        var result = "\(title) \(creator) \(notes ?? "")"
        
        ingredients.forEach {
            result += $0.searchString
        }
        
        categories.forEach {
            result += $0.name
        }
        
        return result.lowercased()
    }
}


