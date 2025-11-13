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
    var recipes: [Recipe]
    
    
    init(name: String, recipes: [Recipe]) {
        self.name = name
        self.recipes = recipes
    }
    
    // addRecipe
    // removeReicpe
}
