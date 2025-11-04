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
    var name: String
    var recipes: [Recipe]
    
    
    init(name: String, recipes: [Recipe]) {
        self.name = name
        self.recipes = recipes
    }
    // addRecipe
    // removeReicpe
}
