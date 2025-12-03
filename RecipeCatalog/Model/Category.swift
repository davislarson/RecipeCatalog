//
//  Category.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/2/25.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var name: String
    
    // Many-to-many relationship with Recipe
    @Relationship(deleteRule: .nullify, inverse: \Recipe.categories) // This is the default functionality but can be explicit.
    var recipes: [Recipe]
    
    
    init(name: String, recipes: [Recipe]) {
        self.name = name
        self.recipes = recipes
    }
    
    func addRecipe(_ recipe: Recipe) {
        if !recipes.contains(where: { $0.title == recipe.title }) {
            recipes.append(recipe)
        }
    }

    func removeRecipe(_ recipe: Recipe) {
        recipes.removeAll(where: { $0.title == recipe.title })
    }
}
