//
//  Instruction.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/2/25.
//

import Foundation
import SwiftData

@Model
final class Instruction {
    var order: Int
    var text: String
    var recipe: Recipe?
    
    init(order: Int, text: String, recipe: Recipe? = nil) {
        self.order = order
        self.text = text
        self.recipe = recipe
    }
    
}
