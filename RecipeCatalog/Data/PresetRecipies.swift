//
//  PresetRecipes.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import Foundation
import SwiftData

struct PresetRecipes {
    static func createDefaultRecipes(context: ModelContext) {
        // Create categories
        let breakfastCategory = Category(name: "Breakfast", recipes: [])
        let quickCategory = Category(name: "Quick", recipes: [])
        let dessertCategory = Category(name: "Desserts", recipes: [])
        let comfortCategory = Category(name: "Comfort Food", recipes: [])
        
        context.insert(breakfastCategory)
        context.insert(quickCategory)
        context.insert(dessertCategory)
        context.insert(comfortCategory)
        
        // Recipe 1: Classic Pancakes
        let pancakeIngredients = [
            Ingredient(order: 1, quantity: 1, unit: "cup", name: "all-purpose flour", notes: nil),
            Ingredient(order: 2, quantity: 2, unit: "tbsp", name: "sugar", notes: nil),
            Ingredient(order: 3, quantity: 2, unit: "tsp", name: "baking powder", notes: nil),
            Ingredient(order: 4, quantity: 1, unit: "pinch", name: "salt", notes: nil),
            Ingredient(order: 5, quantity: 1, unit: "cup", name: "milk", notes: nil),
            Ingredient(order: 6, quantity: 1, unit: "whole", name: "egg", notes: "beaten"),
            Ingredient(order: 7, quantity: 2, unit: "tbsp", name: "melted butter", notes: nil)
        ]
        
        let pancakeInstructions = [
            Instruction(order: 1, text: "In a large bowl, whisk together flour, sugar, baking powder, and salt."),
            Instruction(order: 2, text: "In a separate bowl, whisk together milk, egg, and melted butter."),
            Instruction(order: 3, text: "Pour wet ingredients into dry ingredients and stir until just combined. Don't overmix - a few lumps are okay."),
            Instruction(order: 4, text: "Heat a non-stick pan or griddle over medium heat. Lightly grease with butter."),
            Instruction(order: 5, text: "Pour 1/4 cup batter for each pancake onto the hot griddle."),
            Instruction(order: 6, text: "Cook until bubbles form on the surface and edges look set, about 2-3 minutes."),
            Instruction(order: 7, text: "Flip and cook until golden brown on the other side, about 1-2 minutes more."),
            Instruction(order: 8, text: "Serve hot with maple syrup, butter, and your favorite toppings.")
        ]
        
        let pancakeRecipe = Recipe(
            title: "Classic Fluffy Pancakes",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 20,
            serves: 4,
            difficulty: .beginner,
            caloriesPerServing: 250,
            isFavorite: true,
            notes: "For extra fluffy pancakes, let the batter rest for 5 minutes before cooking.",
            categories: [breakfastCategory, quickCategory],
            ingredients: pancakeIngredients,
            instructions: pancakeInstructions
        )
        
        // Set recipe relationships
        for ingredient in pancakeIngredients {
            ingredient.recipe = pancakeRecipe
        }
        for instruction in pancakeInstructions {
            instruction.recipe = pancakeRecipe
        }
        
        context.insert(pancakeRecipe)
        breakfastCategory.recipes.append(pancakeRecipe)
        quickCategory.recipes.append(pancakeRecipe)
        
        // Recipe 2: Chocolate Chip Cookies
        let cookieIngredients = [
            Ingredient(order: 1, quantity: 2, unit: "cups", name: "all-purpose flour", notes: nil),
            Ingredient(order: 2, quantity: 1, unit: "tsp", name: "baking soda", notes: nil),
            Ingredient(order: 3, quantity: 1, unit: "tsp", name: "salt", notes: nil),
            Ingredient(order: 4, quantity: 1, unit: "cup", name: "butter", notes: "softened"),
            Ingredient(order: 5, quantity: 3, unit: "cups", name: "brown sugar", notes: "packed"),
            Ingredient(order: 6, quantity: 1, unit: "cup", name: "granulated sugar", notes: nil),
            Ingredient(order: 7, quantity: 2, unit: "whole", name: "eggs", notes: nil),
            Ingredient(order: 8, quantity: 2, unit: "tsp", name: "vanilla extract", notes: nil),
            Ingredient(order: 9, quantity: 2, unit: "cups", name: "chocolate chips", notes: nil)
        ]
        
        let cookieInstructions = [
            Instruction(order: 1, text: "Preheat oven to 375°F (190°C)."),
            Instruction(order: 2, text: "In a medium bowl, whisk together flour, baking soda, and salt. Set aside."),
            Instruction(order: 3, text: "In a large bowl, cream together softened butter, brown sugar, and granulated sugar until light and fluffy."),
            Instruction(order: 4, text: "Beat in eggs one at a time, then stir in vanilla extract."),
            Instruction(order: 5, text: "Gradually blend in the flour mixture until just combined."),
            Instruction(order: 6, text: "Fold in chocolate chips with a spatula or wooden spoon."),
            Instruction(order: 7, text: "Drop rounded tablespoons of dough onto ungreased cookie sheets, spacing them about 2 inches apart."),
            Instruction(order: 8, text: "Bake for 9-11 minutes, or until golden brown around the edges."),
            Instruction(order: 9, text: "Let cookies cool on the baking sheet for 2 minutes before transferring to a wire rack to cool completely.")
        ]
        
        let cookieRecipe = Recipe(
            title: "Perfect Chocolate Chip Cookies",
            creator: "Grandma Larson",
            dateCreated: Date(),
            prepTime: 45,
            serves: 48,
            difficulty: .beginner,
            caloriesPerServing: 180,
            isFavorite: false,
            notes: "For chewier cookies, slightly underbake them. They'll continue to cook on the hot pan after removing from oven.",
            categories: [dessertCategory, comfortCategory],
            ingredients: cookieIngredients,
            instructions: cookieInstructions
        )
        
        // Set recipe relationships
        for ingredient in cookieIngredients {
            ingredient.recipe = cookieRecipe
        }
        for instruction in cookieInstructions {
            instruction.recipe = cookieRecipe
        }
        
        context.insert(cookieRecipe)
        dessertCategory.recipes.append(cookieRecipe)
        comfortCategory.recipes.append(cookieRecipe)
        
        // Save the context
        try? context.save()
    }
}
