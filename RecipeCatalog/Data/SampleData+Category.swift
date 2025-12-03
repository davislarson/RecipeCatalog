//
//  SampleData+Category.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import Foundation
import SwiftData

extension Category {
    // MARK: - Categories
    
    static let breakfast = Category(name: "Breakfast", recipes: [])
    static let quick = Category(name: "Quick", recipes: [])
    static let desserts = Category(name: "Desserts", recipes: [])
    static let comfortFood = Category(name: "Comfort Food", recipes: [])
    static let dinner = Category(name: "Dinner", recipes: [])
    static let sandwiches = Category(name: "Sandwiches", recipes: [])
    static let soups = Category(name: "Soups", recipes: [])
    static let cheap = Category(name: "Cheap", recipes: [])
    
    // MARK: - Insert into ModelContext
    static func insertSampleData(modelContext: ModelContext) {
        
        // MARK: - Add Categories
        modelContext.insert(breakfast)
        modelContext.insert(quick)
        modelContext.insert(desserts)
        modelContext.insert(comfortFood)
        modelContext.insert(dinner)
        modelContext.insert(sandwiches)
        modelContext.insert(soups)
        modelContext.insert(cheap)
        
        // MARK: - Cookies
        modelContext.insert(Recipe.cookies)
        
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

        // Assign Categories
        Recipe.cookies.categories = [desserts, comfortFood]
        desserts.recipes.append(Recipe.cookies)
        comfortFood.recipes.append(Recipe.cookies)
        
        // MARK: - Pancakes
        modelContext.insert(Recipe.pancakes)
        
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
        
        // Assign Categories
        Recipe.pancakes.categories = [breakfast, quick]
        breakfast.recipes.append(Recipe.pancakes)
        quick.recipes.append(Recipe.pancakes)
        
        // MARK: - College Chipotle Bowl
        modelContext.insert(Recipe.collegeChipotleBowl)
        
        // Create and insert ingredients
        let collegeChipotleBowlIngredients = Recipe.createCollegeChipBowlIngredients(recipe: Recipe.collegeChipotleBowl)
        for ingredient in collegeChipotleBowlIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.collegeChipotleBowl.ingredients = collegeChipotleBowlIngredients
        
        // Create and insert instructions
        let collegeChipotleBowlInstructions = Recipe.createCollegeChipBowlInstructions(recipe: Recipe.collegeChipotleBowl)
        for instruction in collegeChipotleBowlInstructions {
            modelContext.insert(instruction)
        }
        Recipe.collegeChipotleBowl.instructions = collegeChipotleBowlInstructions
        
        Recipe.collegeChipotleBowl.categories = [cheap, dinner]
        
        // MARK: - Chicken Noodle Soup
        modelContext.insert(Recipe.chickenNoodleSoup)

        // Create and insert ingredients
        let chickenSoupIngredients = Recipe.createChickenNoodleSoupIngredients(recipe: Recipe.chickenNoodleSoup)
        for ingredient in chickenSoupIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.chickenNoodleSoup.ingredients = chickenSoupIngredients

        // Create and insert instructions
        let chickenSoupInstructions = Recipe.createChickenNoodleSoupInstructions(recipe: Recipe.chickenNoodleSoup)
        for instruction in chickenSoupInstructions {
            modelContext.insert(instruction)
        }
        Recipe.chickenNoodleSoup.instructions = chickenSoupInstructions

        // Assign Categories
        Recipe.chickenNoodleSoup.categories = [soups, comfortFood, dinner]
        soups.recipes.append(Recipe.chickenNoodleSoup)
        comfortFood.recipes.append(Recipe.chickenNoodleSoup)
        dinner.recipes.append(Recipe.chickenNoodleSoup)
        
        // MARK: - Grilled Cheese
        modelContext.insert(Recipe.grilledCheese)

        // Create and insert ingredients for grilled cheese
        let grilledCheeseIngredients = Recipe.createGrilledCheeseIngredients(recipe: Recipe.grilledCheese)
        for ingredient in grilledCheeseIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.grilledCheese.ingredients = grilledCheeseIngredients

        // Create and insert instructions for grilled cheese
        let grilledCheeseInstructions = Recipe.createGrilledCheeseInstructions(recipe: Recipe.grilledCheese)
        for instruction in grilledCheeseInstructions {
            modelContext.insert(instruction)
        }
        Recipe.grilledCheese.instructions = grilledCheeseInstructions

        // Assign Categories
        Recipe.grilledCheese.categories = [quick, sandwiches, comfortFood]
        quick.recipes.append(Recipe.grilledCheese)
        sandwiches.recipes.append(Recipe.grilledCheese)
        comfortFood.recipes.append(Recipe.grilledCheese)
        
        // MARK: - Chicken Piccata
        modelContext.insert(Recipe.chickenPiccata)

        // Create and insert ingredients for chicken piccata
        let chickenPiccataIngredients = Recipe.createChickenPiccataIngredients(recipe: Recipe.chickenPiccata)
        for ingredient in chickenPiccataIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.chickenPiccata.ingredients = chickenPiccataIngredients

        // Create and insert instructions for chicken piccata
        let chickenPiccataInstructions = Recipe.createChickenPiccataInstructions(recipe: Recipe.chickenPiccata)
        for instruction in chickenPiccataInstructions {
            modelContext.insert(instruction)
        }
        Recipe.chickenPiccata.instructions = chickenPiccataInstructions

        // Assign Categories
        Recipe.chickenPiccata.categories = [dinner]
        dinner.recipes.append(Recipe.chickenPiccata)
        
        // MARK: - Philly Cheesesteak
        modelContext.insert(Recipe.phillyCheesesteak)

        // Create and insert ingredients for philly cheesesteak
        let phillycheesesteakIngredients = Recipe.createPhillycheesesteakIngredients(recipe: Recipe.phillyCheesesteak)
        for ingredient in phillycheesesteakIngredients {
            modelContext.insert(ingredient)
        }
        Recipe.phillyCheesesteak.ingredients = phillycheesesteakIngredients

        // Create and insert instructions for philly cheesesteak
        let phillycheesesteakInstructions = Recipe.createPhillycheesesteakInstructions(recipe: Recipe.phillyCheesesteak)
        for instruction in phillycheesesteakInstructions {
            modelContext.insert(instruction)
        }
        Recipe.phillyCheesesteak.instructions = phillycheesesteakInstructions

        // Assign Categories
        Recipe.phillyCheesesteak.categories = [sandwiches, dinner, comfortFood]
        sandwiches.recipes.append(Recipe.phillyCheesesteak)
        dinner.recipes.append(Recipe.phillyCheesesteak)
        comfortFood.recipes.append(Recipe.phillyCheesesteak)
    }
    
}
