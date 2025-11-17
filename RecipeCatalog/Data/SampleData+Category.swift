//
//  SampleData+Category.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import Foundation
import SwiftData

extension Category {
    static let breakfast = Category(name: "Breakfast", recipes: [])
    static let quick = Category(name: "Quick", recipes: [])
    static let desserts = Category(name: "Desserts", recipes: [])
    static let comfortFood = Category(name: "Comfort Food", recipes: [])
    
    static func insertSampleData(modelContext: ModelContext) {
        // Add the categories to the model context
        modelContext.insert(breakfast)
        modelContext.insert(quick)
        modelContext.insert(desserts)
        modelContext.insert(comfortFood)
        
        // Add the recipes to the model context
        modelContext.insert(Recipe.pancakes)
        modelContext.insert(Recipe.cookies)
        
        // Create and insert ingredients for pancakes
        let pancakeIngredients = Recipe.createPancakeIngredients(recipe: Recipe.pancakes)
        for ingredient in pancakeIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.pancakes.ingredients = pancakeIngredients
        
        // Create and insert instructions for pancakes
        let pancakeInstructions = Recipe.createPancakeInstructions(recipe: Recipe.pancakes)
        for instruction in pancakeInstructions {
            modelContext.insert(instruction)
        }
        Recipe.pancakes.instructions = pancakeInstructions
        
        // Create and insert ingredients for cookies
        let cookieIngredients = Recipe.createCookieIngredients(recipe: Recipe.cookies)
        for ingredient in cookieIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.cookies.ingredients = cookieIngredients
        
        // Create and insert instructions for cookies
        let cookieInstructions = Recipe.createCookieInstructions(recipe: Recipe.cookies)
        for instruction in cookieInstructions {
            modelContext.insert(instruction)
        }
        Recipe.cookies.instructions = cookieInstructions
        
        // Set the categories for each recipe
        Recipe.pancakes.categories = [breakfast, quick]
        breakfast.recipes.append(Recipe.pancakes)
        quick.recipes.append(Recipe.pancakes)
        
        Recipe.cookies.categories = [desserts, comfortFood]
        desserts.recipes.append(Recipe.cookies)
        comfortFood.recipes.append(Recipe.cookies)
    }
}
