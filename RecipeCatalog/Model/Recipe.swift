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
    
    
    
    // TODO
    //toggleFavorite
    //addIngredient
    //removeIngredient
    //addInstruction
    //removeInstruction
    //addCategory
    //removeCategory
}

enum DifficultyLevel: String, Codable {
    case beginner = "Beginner"
    case intermidiate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"
}


