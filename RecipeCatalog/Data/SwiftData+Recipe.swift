//
//  SwiftData+Recipe.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import Foundation
import SwiftData

extension Recipe {
    // MARK: - Pankcakes
    static let pancakes: Recipe = {
        let recipe = Recipe(
            title: "Classic Fluffy Pancakes",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 20,
            serves: 4,
            difficulty: .beginner,
            caloriesPerServing: 250,
            isFavorite: true,
            notes: "For extra fluffy pancakes, let the batter rest for 5 minutes before cooking.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    // Helper method to create ingredients for pancakes
    static func createPancakeIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1", unit: "cup", name: "all-purpose flour", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "2", unit: "tbsp", name: "sugar", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "2", unit: "tsp", name: "baking powder", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "1", unit: "pinch", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 5, quantity: "1", unit: "cup", name: "milk", notes: nil, recipe: recipe),
            Ingredient(order: 6, quantity: "1", unit: "whole", name: "egg", notes: "beaten", recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "tbsp", name: "melted butter", notes: nil, recipe: recipe)
        ]
    }
    
    // Helper method to create instructions for pancakes
    static func createPancakeInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "In a large bowl, whisk together flour, sugar, baking powder, and salt.", recipe: recipe),
            Instruction(order: 2, text: "In a separate bowl, whisk together milk, egg, and melted butter.", recipe: recipe),
            Instruction(order: 3, text: "Pour wet ingredients into dry ingredients and stir until just combined. Don't overmix - a few lumps are okay.", recipe: recipe),
            Instruction(order: 4, text: "Heat a non-stick pan or griddle over medium heat. Lightly grease with butter.", recipe: recipe),
            Instruction(order: 5, text: "Pour 1/4 cup batter for each pancake onto the hot griddle.", recipe: recipe),
            Instruction(order: 6, text: "Cook until bubbles form on the surface and edges look set, about 2-3 minutes.", recipe: recipe),
            Instruction(order: 7, text: "Flip and cook until golden brown on the other side, about 1-2 minutes more.", recipe: recipe),
            Instruction(order: 8, text: "Serve hot with maple syrup, butter, and your favorite toppings.", recipe: recipe)
        ]
    }
    
    // MARK: - College Chipotle Bowl
    static let collegeChipotleBowl: Recipe = {
        let recipe = Recipe(
            title: "College Chipotle Bowl",
            creator: "Davis+Owen",
            dateCreated: Date(),
            prepTime: 60,
            serves: 8,
            difficulty: .beginner,
            caloriesPerServing: 450,
            isFavorite: false,
            notes: "Quick and easy, dirty and good enough. The better the toppings the better the meal. Good toppings have been avocado, sirracha mayo, salsa, and sour cream. Some spices for the meat could be garlic powder, cumin, paprika, Tony Chacheries... whatever you're feeling.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    // Helper method to create ingredients for college chipotle bowl
    static func createCollegeChipBowlIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "3", unit: "cup", name: "rice", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "can", name: "black beans", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "can", name: "corn", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "2", unit: "can", name: "tomatoes", notes: "best with chilis or habeneros", recipe: recipe),
            Ingredient(order: 5, quantity: "2", unit: "can", name: "beef broth", notes: "unsalted", recipe: recipe),
            Ingredient(order: 6, quantity: "2", unit: "lbs", name: "ground beef", notes: "leaner = easier but less flavor", recipe: recipe),
            Ingredient(order: 7, quantity: "1/2", unit: "cup", name: "red onion", notes: "diced", recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "clove", name: "garlic", notes: "minced", recipe: recipe),
            Ingredient(order: 9, quantity: "1", unit: "cup", name: "cheese", notes: nil, recipe: recipe),
            Ingredient(order: 10, quantity: "1/2", unit: "cup", name: "olive oil", notes: nil, recipe: recipe),
        ]
    }
    
    // Helper method to create instructions for college chipotle bowl
    static func createCollegeChipBowlInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Heat up the olive oil and soften the red onion slightly with the minced garlic.", recipe: recipe),
            Instruction(order: 2, text: "Add the beef and cook until 90% complete, drain excess fat as desired. Add any desired spices.", recipe: recipe),
            Instruction(order: 3, text: "Place the rice in a large pot or wide high brim pan and lightly brown it.", recipe: recipe),
            Instruction(order: 4, text: "Add the beef into the rice along with the beef broth. The broth should barely cover everything in the pot.", recipe: recipe),
            Instruction(order: 5, text: "Let the pot come to a boil than drop the heat and let rice cook for roughly 15-20 minutes.", recipe: recipe),
            Instruction(order: 6, text: "Once the rice is cooked (checking occationally), turn off the heat and add all the canned veggies.", recipe: recipe),
            Instruction(order: 7, text: "Mix together and add the cheese.", recipe: recipe),
            Instruction(order: 8, text: "Add any desired toppings", recipe: recipe),
        ]
    }
    
    // MARK: - Cookies
    static let cookies: Recipe = {
        let recipe = Recipe(
            title: "Perfect Chocolate Chip Cookies",
            creator: "Grandma Larson",
            dateCreated: Date(),
            prepTime: 45,
            serves: 48,
            difficulty: .beginner,
            caloriesPerServing: 180,
            isFavorite: false,
            notes: "For chewier cookies, slightly underbake them. They'll continue to cook on the hot pan after removing from oven.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    
    // Helper method to create ingredients for cookies
    static func createCookieIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "2", unit: "cups", name: "all-purpose flour", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "tsp", name: "baking soda", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "tsp", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "1", unit: "cup", name: "butter", notes: "softened", recipe: recipe),
            Ingredient(order: 5, quantity: "3", unit: "cups", name: "brown sugar", notes: "packed", recipe: recipe),
            Ingredient(order: 6, quantity: "1", unit: "cup", name: "granulated sugar", notes: nil, recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "whole", name: "eggs", notes: nil, recipe: recipe),
            Ingredient(order: 8, quantity: "2", unit: "tsp", name: "vanilla extract", notes: nil, recipe: recipe),
            Ingredient(order: 9, quantity: "2", unit: "cups", name: "chocolate chips", notes: nil, recipe: recipe)
        ]
    }
    
    // Helper method to create instructions for cookies
    static func createCookieInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Preheat oven to 375°F (190°C).", recipe: recipe),
            Instruction(order: 2, text: "In a medium bowl, whisk together flour, baking soda, and salt. Set aside.", recipe: recipe),
            Instruction(order: 3, text: "In a large bowl, cream together softened butter, brown sugar, and granulated sugar until light and fluffy.", recipe: recipe),
            Instruction(order: 4, text: "Beat in eggs one at a time, then stir in vanilla extract.", recipe: recipe),
            Instruction(order: 5, text: "Gradually blend in the flour mixture until just combined.", recipe: recipe),
            Instruction(order: 6, text: "Fold in chocolate chips with a spatula or wooden spoon.", recipe: recipe),
            Instruction(order: 7, text: "Drop rounded tablespoons of dough onto ungreased cookie sheets, spacing them about 2 inches apart.", recipe: recipe),
            Instruction(order: 8, text: "Bake for 9-11 minutes, or until golden brown around the edges.", recipe: recipe),
            Instruction(order: 9, text: "Let cookies cool on the baking sheet for 2 minutes before transferring to a wire rack to cool completely.", recipe: recipe)
        ]
    }
}
