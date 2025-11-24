//
//  Ingredient.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/2/25.
//

import Foundation
import SwiftData


// TODO: create computed var to change format of the quantity
@Model
final class Ingredient {
    var order: Int
    var quantity: String
    var unit: String
    var name: String
    var notes: String?
    
    var recipe: Recipe?
    
    init(order: Int, quantity: String, unit: String, name: String, notes: String? = nil, recipe: Recipe? = nil) {
        self.order = order
        self.quantity = quantity
        self.unit = unit
        self.name = name
        self.notes = notes
        self.recipe = recipe
    }

}
